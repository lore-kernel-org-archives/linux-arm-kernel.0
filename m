From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Thu,  1 Jan 2015 17:45:05 +0100
Subject: [PATCH] arch: arm: plat-omap: dma.c:  Remove unused function
Message-ID: <1420130705-29316-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the function get_gdma_dev() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/plat-omap/dma.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 24770e5..6416e03 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -151,14 +151,6 @@ static int omap_dma_in_1510_mode(void)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP1
-static inline int get_gdma_dev(int req)
-{
-	u32 reg = OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
-	int shift = ((req - 1) % 5) * 6;
-
-	return ((omap_readl(reg) >> shift) & 0x3f) + 1;
-}
-
 static inline void set_gdma_dev(int req, int dev)
 {
 	u32 reg = OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
-- 
1.7.10.4
