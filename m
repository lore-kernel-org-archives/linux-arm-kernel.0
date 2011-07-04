From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:50:17 +0100
Subject: [PATCH 08/10] ARM: dmabounce: correct unmap_single dev_dbg
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1QderB-0000ZZ-0A@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DMA addresses should not be casted to void * for printing.  Fix
that to be consistent with the rest of the file.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index b4a8759..4f13505 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -345,8 +345,8 @@ void __dma_unmap_page(struct device *dev, dma_addr_t dma_addr, size_t size,
 {
 	struct safe_buffer *buf;
 
-	dev_dbg(dev, "%s(ptr=%p,size=%d,dir=%x)\n",
-		__func__, (void *) dma_addr, size, dir);
+	dev_dbg(dev, "%s(dma=%#x,size=%d,dir=%x)\n",
+		__func__, dma_addr, size, dir);
 
 	buf = find_safe_buffer_dev(dev, dma_addr, __func__);
 	if (!buf) {
-- 
1.7.4.4
