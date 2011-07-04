From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:48:36 +0100
Subject: [PATCH 03/10] ARM: dmabounce: avoid needless valid_dma_direction()
	check
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1QdepY-0000ZD-EE@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This check is done at the DMA API level, so there's no point repeating
it here.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 8a0588b..3e0fa15 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -334,8 +334,6 @@ dma_addr_t __dma_map_page(struct device *dev, struct page *page,
 	dev_dbg(dev, "%s(page=%p,off=%#lx,size=%zx,dir=%x)\n",
 		__func__, page, offset, size, dir);
 
-	BUG_ON(!valid_dma_direction(dir));
-
 	if (PageHighMem(page)) {
 		dev_err(dev, "DMA buffer bouncing of HIGHMEM pages "
 			     "is not supported\n");
-- 
1.7.4.4
