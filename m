From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 13 Jan 2015 16:57:40 +0530
Subject: [PATCH 1/3] clk: samsung: exynos7: add gate clock for DMA block
In-Reply-To: <1421148462-11755-1-git-send-email-padma.v@samsung.com>
References: <1421148462-11755-1-git-send-email-padma.v@samsung.com>
Message-ID: <1421148462-11755-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for PDMA0 and PDMA1 gate clks.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos7.c       |    4 ++++
 include/dt-bindings/clock/exynos7-clk.h |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7.c b/drivers/clk/samsung/clk-exynos7.c
index 945f41c..d01d766 100644
--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -722,6 +722,10 @@ static struct samsung_gate_clock fsys0_gate_clks[] __initdata = {
 	GATE(ACLK_AXIUS_USBDRD30X_FSYS0X, "aclk_axius_usbdrd30x_fsys0x",
 		"mout_aclk_fsys0_200_user",
 		ENABLE_ACLK_FSYS00, 19, 0, 0),
+	GATE(ACLK_PDMA1, "aclk_pdma1", "mout_aclk_fsys0_200_user",
+			ENABLE_ACLK_FSYS00, 3, 0, 0),
+	GATE(ACLK_PDMA0, "aclk_pdma0", "mout_aclk_fsys0_200_user",
+			ENABLE_ACLK_FSYS00, 4, 0, 0),
 
 	GATE(ACLK_USBDRD300, "aclk_usbdrd300", "mout_aclk_fsys0_200_user",
 		ENABLE_ACLK_FSYS01, 29, 0, 0),
diff --git a/include/dt-bindings/clock/exynos7-clk.h b/include/dt-bindings/clock/exynos7-clk.h
index e33d0ca..05e2a47 100644
--- a/include/dt-bindings/clock/exynos7-clk.h
+++ b/include/dt-bindings/clock/exynos7-clk.h
@@ -91,7 +91,9 @@
 #define PHYCLK_USBDRD300_UDRD30_PIPE_PCLK_USER		6
 #define PHYCLK_USBDRD300_UDRD30_PHYCLK_USER		7
 #define OSCCLK_PHY_CLKOUT_USB30_PHY		8
-#define FSYS0_NR_CLK			9
+#define ACLK_PDMA0			9
+#define ACLK_PDMA1			10
+#define FSYS0_NR_CLK			11
 
 /* FSYS1 */
 #define ACLK_MMC1			1
-- 
1.7.4.4
