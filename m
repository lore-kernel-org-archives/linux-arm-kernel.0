From: axel.lin@ingics.com (Axel Lin)
Date: Tue, 01 Sep 2015 10:04:33 +0800
Subject: ARM: pxa: build error in arch/arm/plat-pxa/ssp.c
Message-ID: <1441073073.12012.3.camel@ingics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  CC [M]  arch/arm/plat-pxa/ssp.o
arch/arm/plat-pxa/ssp.c:110:52: error: 'LPSS_SSP' undeclared here (not in a function)
scripts/Makefile.build:264: recipe for target 'arch/arm/plat-pxa/ssp.o' failed
make[1]: *** [arch/arm/plat-pxa/ssp.o] Error 1
Makefile:965: recipe for target 'arch/arm/plat-pxa' failed
make: *** [arch/arm/plat-pxa] Error 2


The build error is introduced by:
commit 03fbf488cece461468d3abb795f5e5f055e00040
Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date:   Thu Jun 4 16:55:10 2015 +0300

    spi: pxa2xx: Differentiate Intel LPSS types
