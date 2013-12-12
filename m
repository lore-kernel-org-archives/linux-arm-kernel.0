From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Thu, 12 Dec 2013 08:32:00 +0530
Subject: [PATCH 1/3] clk: samsung: exynos5250: Fix ACP gate register offset
Message-ID: <1386817322-11265-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLK_GATE_IP_ACP register offset is incorrectly listed.
Fix this and the register ordering as well.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index adf3234..cbba4a8 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -25,6 +25,7 @@
 #define MPLL_LOCK		0x4000
 #define MPLL_CON0		0x4100
 #define SRC_CORE1		0x4204
+#define GATE_IP_ACP		0x8800
 #define CPLL_LOCK		0x10020
 #define EPLL_LOCK		0x10030
 #define VPLL_LOCK		0x10040
@@ -75,7 +76,6 @@
 #define SRC_CDREX		0x20200
 #define PLL_DIV2_SEL		0x20a24
 #define GATE_IP_DISP1		0x10928
-#define GATE_IP_ACP		0x10000
 
 /* list of PLLs to be registered */
 enum exynos5250_plls {
-- 
1.7.9.5
