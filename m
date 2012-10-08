From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 8 Oct 2012 18:26:18 +0800
Subject: [PATCH 4/7] ARM: tegra30: common: enable csite clock
In-Reply-To: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
Message-ID: <1349691981-31038-5-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable csite (debug and trace controller) clock at init to prevent it
be disabled. And this also the necessary clock for CPU be brought up or
resumed from a power-gate low power state (e.g., LP2).

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/mach-tegra/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 0b0a5f5..4a2dd98 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -104,6 +104,7 @@ static __initdata struct tegra_clk_init_table tegra30_clk_init_table[] = {
 	{ "clk_m",	NULL,		0,		true },
 	{ "pll_p",	"clk_m",	408000000,	true },
 	{ "pll_p_out1",	"pll_p",	9600000,	true },
+	{ "csite",	NULL,		0,		true },
 	{ NULL,		NULL,		0,		0},
 };
 #endif
-- 
1.7.0.4
