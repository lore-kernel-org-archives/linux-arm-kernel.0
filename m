From: prakity@marvell.com (Philip Rakity)
Date: Fri, 21 Jan 2011 10:45:14 -0800
Subject: ARM: mach-mmp: SDH register definitions for (pxa168, pxa910, mmp2)
Message-ID: <55E83F63-00EC-4D2F-B97E-161E4FE82F2D@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Register definitions added for APMU registers for all platforms
Definitions are platform dependent (not same for pxa168, pxz910, mmp2).

mmp2.c modified to use correct platform registers for MMC/SDH.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/include/mach/regs-apmu.h |   18 ++++++++++++++----
 arch/arm/mach-mmp/mmp2.c                   |    8 ++++----
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp/include/mach/regs-apmu.h
index f7011ef..9d1146f 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
@@ -20,15 +20,25 @@
 #define APMU_IRE	APMU_REG(0x048)
 #define APMU_LCD	APMU_REG(0x04c)
 #define APMU_CCIC	APMU_REG(0x050)
-#define APMU_SDH0	APMU_REG(0x054)
-#define APMU_SDH1	APMU_REG(0x058)
 #define APMU_USB	APMU_REG(0x05c)
 #define APMU_NAND	APMU_REG(0x060)
 #define APMU_DMA	APMU_REG(0x064)
 #define APMU_GEU	APMU_REG(0x068)
 #define APMU_BUS	APMU_REG(0x06c)
-#define APMU_SDH2	APMU_REG(0x0e8)
-#define APMU_SDH3	APMU_REG(0x0ec)
+
+#define APMU_PXA168_SDH0	APMU_REG(0x054)
+#define APMU_PXA168_SDH1	APMU_REG(0x058)
+#define APMU_PXA168_SDH2	APMU_REG(0x0e0)
+#define APMU_PXA168_SDH3	APMU_REG(0x0e4)
+
+#define APMU_PXA910_SDH0	APMU_REG(0x054)
+#define APMU_PXA910_SDH1	APMU_REG(0x058)
+#define APMU_PXA910_SDH2	APMU_REG(0x0e0)
+
+#define APMU_MMP2_SDH0	APMU_REG(0x054)
+#define APMU_MMP2_SDH1	APMU_REG(0x058)
+#define APMU_MMP2_SDH2	APMU_REG(0x0e8)
+#define APMU_MMP2_SDH3	APMU_REG(0x0ec)
 
 #define APMU_FNCLK_EN	(1 << 4)
 #define APMU_AXICLK_EN	(1 << 3)
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 8e6c3ac..564bfbc 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -151,10 +151,10 @@ static APBC_CLK(twsi5, MMP2_TWSI5, 0, 26000000);
 static APBC_CLK(twsi6, MMP2_TWSI6, 0, 26000000);
 
 static APMU_CLK(nand, NAND, 0xbf, 100000000);
-static APMU_CLK_OPS(sdh0, SDH0, 0x1b, 200000000, &sdhc_clk_ops);
-static APMU_CLK_OPS(sdh1, SDH1, 0x1b, 200000000, &sdhc_clk_ops);
-static APMU_CLK_OPS(sdh2, SDH2, 0x1b, 200000000, &sdhc_clk_ops);
-static APMU_CLK_OPS(sdh3, SDH3, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh0, MMP2_SDH0, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh1, MMP2_SDH1, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh2, MMP2_SDH2, 0x1b, 200000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh3, MMP2_SDH3, 0x1b, 200000000, &sdhc_clk_ops);
 
 static struct clk_lookup mmp2_clkregs[] = {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
-- 
1.7.0.4
