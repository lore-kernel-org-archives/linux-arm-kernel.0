From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 05 Aug 2014 12:47:31 +0200
Subject: [PATCH 03/29] clk: exynos: add missing smmu_g2d clock and update
 comments
In-Reply-To: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1407235677-26324-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing smmu_g2d clock implementation and updates
comment about Exynos4 clocks from 278-282 range. Those clocks are
available on all Exynos4 SoC series, so the misleading comment has been
removed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c   |  1 +
 include/dt-bindings/clock/exynos4.h | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index ac163d7..12a7cc3 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1183,6 +1183,7 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 	GATE(CLK_SPI1_ISP, "spi1_isp", "aclk200", E4X12_GATE_ISP1, 13,
 			CLK_IGNORE_UNUSED | CLK_GET_RATE_NOCACHE, 0),
 	GATE(CLK_G2D, "g2d", "aclk200", GATE_IP_DMC, 23, 0, 0),
+	GATE(CLK_SMMU_G2D, "smmu_g2d", "aclk200", GATE_IP_DMC, 24, 0, 0),
 	GATE(CLK_TMU_APBIF, "tmu_apbif", "aclk100", E4X12_GATE_IP_PERIR, 17, 0,
 		0),
 };
diff --git a/include/dt-bindings/clock/exynos4.h b/include/dt-bindings/clock/exynos4.h
index 459bd2b..fb981635 100644
--- a/include/dt-bindings/clock/exynos4.h
+++ b/include/dt-bindings/clock/exynos4.h
@@ -115,11 +115,11 @@
 #define CLK_SMMU_MFCR		275
 #define CLK_G3D			276
 #define CLK_G2D			277
-#define CLK_ROTATOR		278 /* Exynos4210 only */
-#define CLK_MDMA		279 /* Exynos4210 only */
-#define CLK_SMMU_G2D		280 /* Exynos4210 only */
-#define CLK_SMMU_ROTATOR	281 /* Exynos4210 only */
-#define CLK_SMMU_MDMA		282 /* Exynos4210 only */
+#define CLK_ROTATOR		278
+#define CLK_MDMA		279
+#define CLK_SMMU_G2D		280
+#define CLK_SMMU_ROTATOR	281
+#define CLK_SMMU_MDMA		282
 #define CLK_FIMD0		283
 #define CLK_MIE0		284
 #define CLK_MDNIE0		285 /* Exynos4412 only */
-- 
1.9.2
