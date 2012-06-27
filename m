From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 27 Jun 2012 15:46:04 -0400
Subject: commit "ARM: dma-mapping: remove custom consistent dma region"
Message-ID: <20120627194604.GA9445@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

This commit in linux-next:

commit feb930cb9beb75cbe1d1e798870599c3aa1b93ec
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri Jun 8 12:08:32 2012 +0200

    ARM: dma-mapping: remove custom consistent dma region

seems to break the at91x40_defconfig (according to git bisect).

  CC      arch/arm/mm/dma-mapping.o
arch/arm/mm/dma-mapping.c: In function '__dma_alloc':
arch/arm/mm/dma-mapping.c:575: error: macro "__alloc_from_pool" requires 4 arguments, but only 2 given
arch/arm/mm/dma-mapping.c:575: error: '__alloc_from_pool' undeclared (first use in this function)
arch/arm/mm/dma-mapping.c:575: error: (Each undeclared identifier is reported only once
arch/arm/mm/dma-mapping.c:575: error: for each function it appears in.)
make[2]: *** [arch/arm/mm/dma-mapping.o] Error 1
make[1]: *** [arch/arm/mm/dma-mapping.o] Error 2

See http://kisskb.ellerman.id.au/kisskb/buildresult/6596769/ for a full log.

Please have a look when you get a chance.

Thanks,
Paul.
