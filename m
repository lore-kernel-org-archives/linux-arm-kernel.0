From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 29 Oct 2012 18:28:18 +0800
Subject: [PATCH V3 4/7] ARM: tegra30: common: enable csite clock
In-Reply-To: <1351506501-600-1-git-send-email-josephl@nvidia.com>
References: <1351506501-600-1-git-send-email-josephl@nvidia.com>
Message-ID: <1351506501-600-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable csite (debug and trace controller) clock at init to prevent it
be disabled. And this also the necessary clock for CPU be brought up or
resumed from a power-gating low power state.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* update the commit message
V2:
* no change
---
 arch/arm/mach-tegra/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index d2d6dbb..a8f9175 100644
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
