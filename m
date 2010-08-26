From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 26 Aug 2010 15:28:39 +0900
Subject: [PATCH V2 13/14] ARM: S5PV310: Add video clocks
In-Reply-To: <1282804120-17241-1-git-send-email-kgene.kim@samsung.com>
References: <1282804120-17241-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1282804120-17241-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds video clocks for S5PV310/S5PC210.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- Restored regarding mipi clocks

 arch/arm/mach-s5pv310/clock.c |   48 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
index 1f9ed85..b6ad76f 100644
--- a/arch/arm/mach-s5pv310/clock.c
+++ b/arch/arm/mach-s5pv310/clock.c
@@ -588,6 +588,54 @@ static struct clksrc_sources clkset_group = {
 	.nr_sources	= ARRAY_SIZE(clkset_group_list),
 };
 
+static struct clk *clkset_mout_g2d0_list[] = {
+	[0] = &clk_mout_mpll.clk,
+	[1] = &clk_sclk_apll.clk,
+};
+
+static struct clksrc_sources clkset_mout_g2d0 = {
+	.sources	= clkset_mout_g2d0_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mout_g2d0_list),
+};
+
+static struct clksrc_clk clk_mout_g2d0 = {
+	.clk	= {
+		.name		= "mout_g2d0",
+		.id		= -1,
+	},
+	.sources	= &clkset_mout_g2d0,
+	.reg_src	= { .reg = S5P_CLKSRC_IMAGE, .shift = 0, .size = 1 },
+};
+
+static struct clk *clkset_mout_g2d1_list[] = {
+	[0] = &clk_mout_epll.clk,
+	[1] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_mout_g2d1 = {
+	.sources	= clkset_mout_g2d1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mout_g2d1_list),
+};
+
+static struct clksrc_clk clk_mout_g2d1 = {
+	.clk	= {
+		.name		= "mout_g2d1",
+		.id		= -1,
+	},
+	.sources	= &clkset_mout_g2d1,
+	.reg_src	= { .reg = S5P_CLKSRC_IMAGE, .shift = 4, .size = 1 },
+};
+
+static struct clk *clkset_mout_g2d_list[] = {
+	[0] = &clk_mout_g2d0.clk,
+	[1] = &clk_mout_g2d1.clk,
+};
+
+static struct clksrc_sources clkset_mout_g2d = {
+	.sources	= clkset_mout_g2d_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mout_g2d_list),
+};
+
 static struct clksrc_clk clk_dout_mmc0 = {
 	.clk		= {
 		.name		= "dout_mmc0",
-- 
1.6.2.5
