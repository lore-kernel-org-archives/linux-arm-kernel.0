From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 9 Aug 2011 23:08:11 +0200
Subject: [PATCH V3] ARM: tegra: paz00: add clocks required for usb operation
Message-ID: <201108092308.11580.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


These clocks are required for usb operation. pll_p_out4 needs to be set
to 24 MHz. The other clocks default to "off" in order to safe some energy.
---
 arch/arm/mach-tegra/board-paz00.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-
paz00.c
index 45111f6..cde36dc 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -145,6 +145,12 @@ static __initdata struct tegra_clk_init_table 
paz00_clk_init_table[] = {
 	/* name		parent		rate		enabled */
 	{ "uarta",	"pll_p",	216000000,	true },
 	{ "uartd",	"pll_p",	216000000,	true },
+
+	{ "pll_p_out4",	"pll_p",	24000000,	true },
+	{ "usbd",	"clk_m",	12000000,	false },
+	{ "usb2",	"clk_m",	12000000,	false },
+	{ "usb3",	"clk_m",	12000000,	false },
+
 	{ NULL,		NULL,		0,		0},
 };
 
-- 
1.7.4.1
