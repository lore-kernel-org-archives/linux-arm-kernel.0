From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Jan 2015 17:23:31 +0000
Subject: [PATCH 0/2] A couple of DMA teardown fixes for 3.19
Message-ID: <1421083413-24798-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are a couple of DMA teardown fixes for 3.19. The first patch adds
a call to of_dma_deconfigure on device destruction and the second patch
fixes a redundant "Not attached" message on the console when a device
without an IOMMU is destroyed on ARM.

I guess the second patch can go independently via rmk?

Will

Will Deacon (2):
  of/platform: teardown DMA mappings on device destruction
  ARM: dma-mapping: don't detach devices without an IOMMU during
    teardown

 arch/arm/mm/dma-mapping.c | 5 ++++-
 drivers/of/platform.c     | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.1.4
