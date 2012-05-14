From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 14 May 2012 19:47:16 -0400
Subject: linux-next commit "ARM: dma-mapping: move all dma bounce code to
 separate dma ops structure"
Message-ID: <4FB19984.5050504@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Can you have a re-visit to this commit?

commit 3c7c51817e8666aa507104d1ae624c5113ecbe01
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri Feb 10 19:55:20 2012 +0100

    ARM: dma-mapping: move all dma bounce code to separate dma ops structure

It seems some builds were still relying on the old behaviour,
as git bisect on one of the fails led to the above commit.

Here is the failure:

arch/arm/common/dmabounce.c:459:12: error: 'generic_dma_map_sg' undeclared here (not in a function)
arch/arm/common/dmabounce.c:460:14: error: 'generic_dma_unmap_sg' undeclared here (not in a function)
arch/arm/common/dmabounce.c:461:21: error: 'generic_dma_sync_sg_for_cpu' undeclared here (not in a function)
arch/arm/common/dmabounce.c:462:24: error: 'generic_dma_sync_sg_for_device' undeclared here (not in a function)
make[2]: *** [arch/arm/common/dmabounce.o] Error 1

It happens on several ARM in-tree defconfig files, such as these.

http://kisskb.ellerman.id.au/kisskb/buildresult/6320182/

http://kisskb.ellerman.id.au/kisskb/buildresult/6320161/

http://kisskb.ellerman.id.au/kisskb/buildresult/6294024/

http://kisskb.ellerman.id.au/kisskb/buildresult/6320159/

Thanks,
Paul.
