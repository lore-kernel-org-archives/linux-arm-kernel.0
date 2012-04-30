From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 30 Apr 2012 12:14:13 -0700
Subject: [PATCH 03/20] ARM: EXYNOS: fix ctrlbit for exynos5_clk_pdma1
In-Reply-To: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1335813270-13083-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kukjin Kim <kgene.kim@samsung.com>

It should be (1 << 2) for ctrlbit of exynos5_clk_pdma1.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/clock-exynos5.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/clock-exynos5.c b/arch/arm/mach-exynos/clock-exynos5.c
index 3dc3c50..846741e 100644
--- a/arch/arm/mach-exynos/clock-exynos5.c
+++ b/arch/arm/mach-exynos/clock-exynos5.c
@@ -683,7 +683,7 @@ static struct clk exynos5_clk_pdma1 = {
 	.name		= "dma",
 	.devname	= "dma-pl330.1",
 	.enable		= exynos5_clk_ip_fsys_ctrl,
-	.ctrlbit	= (1 << 1),
+	.ctrlbit	= (1 << 2),
 };
 
 static struct clk exynos5_clk_mdma1 = {
-- 
1.7.5.4
