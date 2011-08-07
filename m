From: marvin24@gmx.de (Marc Dietrich)
Date: Sun,  7 Aug 2011 21:00:54 +0200
Subject: [PATCH 4/5] ARM: tegra: paz00: add clocks required for usb operation
In-Reply-To: <cover.1312735430.git.marvin24@gmx.de>
References: <cover.1312735430.git.marvin24@gmx.de>
Message-ID: <76f31183766f1edce1230a925ced1c986dbdf028.1312742856.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These clocks are required for usb operation.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 45111f6..8a2d1ce 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -145,6 +145,11 @@ static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
 	/* name		parent		rate		enabled */
 	{ "uarta",	"pll_p",	216000000,	true },
 	{ "uartd",	"pll_p",	216000000,	true },
+
+	{ "pll_a",      "pll_p_out1",   56448000,       true },
+	{ "pll_a_out0", "pll_a",        11289600,       true },
+	{ "pll_p_out4", "pll_p",        24000000,       true },
+
 	{ NULL,		NULL,		0,		0},
 };
 
-- 
1.7.4.1
