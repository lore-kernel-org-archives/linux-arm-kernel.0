From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 19 Oct 2012 16:48:43 +0800
Subject: [PATCH V2 4/7] ARM: tegra30: common: enable csite clock
In-Reply-To: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
References: <1350636526-25920-1-git-send-email-josephl@nvidia.com>
Message-ID: <1350636526-25920-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable csite (debug and trace controller) clock at init to prevent it
be disabled. And this also the necessary clock for CPU be brought up or
resumed from a power-gate low power state (e.g., LP2).

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* same with V1

 arch/arm/mach-tegra/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 177f164..0e31f8c 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -108,6 +108,7 @@ static __initdata struct tegra_clk_init_table tegra30_clk_init_table[] = {
 	{ "sclk",	"pll_p_out4",	102000000,	true },
 	{ "hclk",	"sclk",		102000000,	true },
 	{ "pclk",	"hclk",		51000000,	true },
+	{ "csite",	NULL,		0,		true },
 	{ NULL,		NULL,		0,		0},
 };
 #endif
-- 
1.7.0.4
