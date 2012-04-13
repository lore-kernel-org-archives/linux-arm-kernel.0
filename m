From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Apr 2012 16:42:04 -0600
Subject: [PATCH 3/5] ARM: tegra: change pll_p_out4's rate to 24MHz
In-Reply-To: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
References: <1334356926-4275-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1334356926-4275-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

pll_p_out4 is used on all/most Tegra boards to drive the cdev2 output pin
to provide a reference clock to a ULPI USB PHY. This reference clock must
run at 24MHz, and the cdev2 output has no additional dividers.

Remove board-paz00.c's now-duplicate initialization of this clock.

Reported-by: Marc Dietrich <marvin24@gmx.de>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-paz00.c |    1 -
 arch/arm/mach-tegra/common.c      |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 330afdf..aebfa40 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -176,7 +176,6 @@ static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
 	{ "uarta",	"pll_p",	216000000,	true },
 	{ "uartc",	"pll_p",	216000000,	true },
 
-	{ "pll_p_out4",	"pll_p",	24000000,	true },
 	{ "usbd",	"clk_m",	12000000,	false },
 	{ "usb2",	"clk_m",	12000000,	false },
 	{ "usb3",	"clk_m",	12000000,	false },
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index e969004..c50f2ee 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -82,7 +82,7 @@ static __initdata struct tegra_clk_init_table tegra20_clk_init_table[] = {
 	{ "pll_p_out1",	"pll_p",	28800000,	true },
 	{ "pll_p_out2",	"pll_p",	48000000,	true },
 	{ "pll_p_out3",	"pll_p",	72000000,	true },
-	{ "pll_p_out4",	"pll_p",	108000000,	true },
+	{ "pll_p_out4",	"pll_p",	24000000,	true },
 	{ "pll_c",	"clk_m",	600000000,	true },
 	{ "pll_c_out1",	"pll_c",	120000000,	true },
 	{ "sclk",	"pll_c_out1",	120000000,	true },
-- 
1.7.0.4
