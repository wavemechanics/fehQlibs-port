# $FreeBSD$

PORTNAME=	fehQlibs
DISTVERSION=	14
CATEGORIES=	sysutils
MASTER_SITES=	https://www.fehcom.de/ipnet/fehQlibs/
EXTRACT_SUFX=   .tgz

MAINTAINER=	dl-ports@perfec.to
COMMENT=	State-of-the-art C routines provided as easy-to-use library for Internet services
LICENSE=	PD
LICENSE_FILE=	${WRKSRC}/LICENSE

do-configure:
	echo "LIBDIR=${STAGEDIR}${PREFIX}/lib" >> ${WRKSRC}/conf-build
	echo "HDRDIR=${STAGEDIR}${PREFIX}/include" >> ${WRKSRC}/conf-build

do-build:
	cd ${WRKSRC} && make default && make shared

# Not sure if we want to install shared libs yet.
# Would use RLN except it links to resolved names instead of just doing what I ask.
do-install:
	cd ${WRKSRC} && make install
	#for so in libdnsresolv.so libqlibs.so; \
	#do \
	#	${INSTALL_LIB} ${WRKSRC}/$${so} ${STAGEDIR}${PREFIX}/lib/$${so}.14.0; \
	#	cd ${STAGEDIR}${PREFIX}/lib && \
	#	    ${LN} -s $${so}.14.0 $${so}.14 && \
  	#	    ${LN} -s $${so}.14 $${so}; \
	#done
	${INSTALL_MAN} ${WRKSRC}/man/*.3 ${STAGEDIR}${MANPREFIX}/man/man3

.include <bsd.port.mk>
