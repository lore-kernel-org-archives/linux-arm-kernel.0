From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 22 Oct 2012 20:44:03 +0800
Subject: [PATCH] ARM: dma-mapping: support debug_dma_mapping_error
Message-ID: <1350909843-5273-1-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without the patch, kind of below warning will be dumped if DMA-API
debug is enabled:

[   11.069763] ------------[ cut here ]------------
[   11.074645] WARNING: at lib/dma-debug.c:948 check_unmap+0x770/0x860()
[   11.081420] ehci-omap ehci-omap.0: DMA-API: device driver failed to
check map error[device address=0x0000000
0adb78e80] [size=8 bytes] [mapped as single]
[   11.095611] Modules linked in:

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/include/asm/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 2300484..78d8e9b 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -91,6 +91,7 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
  */
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
+	debug_dma_mapping_error(dev, dma_addr);
 	return dma_addr == DMA_ERROR_CODE;
 }
 
-- 
1.7.9.5
