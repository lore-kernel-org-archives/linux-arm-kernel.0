From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 17 Apr 2012 11:16:28 +0530
Subject: [PATCH 05/12] ARM: Exynos5: Add MDMA0 clock instance
In-Reply-To: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1334641595-25301-6-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock instance for MDMA0 controller.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/clock-exynos5.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index fb95e9b..0230ba8 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -768,9 +768,14 @@ static struct clk exynos5_clk_pdma = {
 	.ctrlbit	= (1 << 1),
 };
 
+static struct clk exynos5_clk_mdma0 = {
+	.name		= "dma",
+	.enable		= exynos5_clk_ip_acp_ctrl,
+	.ctrlbit	= (1 << 1),
+};
+
 static struct clk exynos5_clk_mdma1 = {
 	.name		= "dma",
-	.devname	= "dma-pl330.2",
 	.enable		= exynos5_clk_ip_gen_ctrl,
 	.ctrlbit	= (1 << 4),
 };
@@ -1057,6 +1062,7 @@ static struct clksrc_clk *exynos5_sysclks[] = {
 
 static struct clk *exynos5_clk_cdev[] = {
 	&exynos5_clk_pdma,
+	&exynos5_clk_mdma0,
 	&exynos5_clk_mdma1,
 };
 
@@ -1082,7 +1088,8 @@ static struct clk_lookup exynos5_clk_lookup[] = {
 	CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &exynos5_clk_sclk_mmc3.clk),
 	CLKDEV_INIT("dma-pl330.0", "apb_pclk", &exynos5_clk_pdma),
 	CLKDEV_INIT("dma-pl330.1", "apb_pclk", &exynos5_clk_pdma),
-	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma1),
+	CLKDEV_INIT("dma-pl330.2", "apb_pclk", &exynos5_clk_mdma0),
+	CLKDEV_INIT("dma-pl330.3", "apb_pclk", &exynos5_clk_mdma1),
 };
 
 static unsigned long exynos5_epll_get_rate(struct clk *clk)
-- 
1.6.6.rc2
