From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 09:39:00 +0900
Subject: [PATCH 15/18] ARM: S5PV210: Add sclk_audio and sclk_spdif clocks.
Message-ID: <1274056740-14680-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Add the sclk_audio(0/1/2) clocks and sclk_spdif clock of type
'struct clksrc_clk' clock. Also, add clk_pcmcdclk(0/1/2) clocks
of type 'struct clk' clock.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/clock.c |  125 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
index c03e288..0154710 100644
--- a/arch/arm/mach-s5pv210/clock.c
+++ b/arch/arm/mach-s5pv210/clock.c
@@ -199,6 +199,21 @@ static struct clk clk_sclk_usbphy1 = {
 	.id		= -1,
 };
 
+static struct clk clk_pcmcdclk0 = {
+	.name		= "pcmcdclk",
+	.id		= -1,
+};
+
+static struct clk clk_pcmcdclk1 = {
+	.name		= "pcmcdclk",
+	.id		= -1,
+};
+
+static struct clk clk_pcmcdclk2 = {
+	.name		= "pcmcdclk",
+	.id		= -1,
+};
+
 static struct clk *clkset_vpllsrc_list[] = {
 	[0] = &clk_fin_vpll,
 	[1] = &clk_sclk_hdmi27m,
@@ -524,6 +539,104 @@ static struct clksrc_sources clkset_sclk_mixer = {
 	.nr_sources	= ARRAY_SIZE(clkset_sclk_mixer_list),
 };
 
+static struct clk *clkset_sclk_audio0_list[] = {
+	[0] = &clk_ext_xtal_mux,
+	[1] = &clk_pcmcdclk0,
+	[2] = &clk_sclk_hdmi27m,
+	[3] = &clk_sclk_usbphy0,
+	[4] = &clk_sclk_usbphy1,
+	[5] = &clk_sclk_hdmiphy,
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+	[8] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_sclk_audio0 = {
+	.sources	= clkset_sclk_audio0_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio0_list),
+};
+
+static struct clksrc_clk clk_sclk_audio0 = {
+	.clk		= {
+		.name		= "sclk_audio",
+		.id		= 0,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 4),
+	},
+	.sources = &clkset_sclk_audio0,
+	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 0, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 0, .size = 4 },
+};
+
+static struct clk *clkset_sclk_audio1_list[] = {
+	[0] = &clk_ext_xtal_mux,
+	[1] = &clk_pcmcdclk1,
+	[2] = &clk_sclk_hdmi27m,
+	[3] = &clk_sclk_usbphy0,
+	[4] = &clk_sclk_usbphy1,
+	[5] = &clk_sclk_hdmiphy,
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+	[8] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_sclk_audio1 = {
+	.sources	= clkset_sclk_audio1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio1_list),
+};
+
+static struct clksrc_clk clk_sclk_audio1 = {
+	.clk		= {
+		.name		= "sclk_audio",
+		.id		= 1,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 5),
+	},
+	.sources = &clkset_sclk_audio1,
+	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 4, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 4, .size = 4 },
+};
+
+static struct clk *clkset_sclk_audio2_list[] = {
+	[0] = &clk_ext_xtal_mux,
+	[1] = &clk_pcmcdclk0,
+	[2] = &clk_sclk_hdmi27m,
+	[3] = &clk_sclk_usbphy0,
+	[4] = &clk_sclk_usbphy1,
+	[5] = &clk_sclk_hdmiphy,
+	[6] = &clk_mout_mpll.clk,
+	[7] = &clk_mout_epll.clk,
+	[8] = &clk_sclk_vpll.clk,
+};
+
+static struct clksrc_sources clkset_sclk_audio2 = {
+	.sources	= clkset_sclk_audio2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio2_list),
+};
+
+static struct clksrc_clk clk_sclk_audio2 = {
+	.clk		= {
+		.name		= "sclk_audio",
+		.id		= 2,
+		.enable		= s5pv210_clk_ip3_ctrl,
+		.ctrlbit	= (1 << 6),
+	},
+	.sources = &clkset_sclk_audio2,
+	.reg_src = { .reg = S5P_CLK_SRC6, .shift = 8, .size = 4 },
+	.reg_div = { .reg = S5P_CLK_DIV6, .shift = 8, .size = 4 },
+};
+
+static struct clk *clkset_sclk_spdif_list[] = {
+	[0] = &clk_sclk_audio0.clk,
+	[1] = &clk_sclk_audio1.clk,
+	[2] = &clk_sclk_audio2.clk,
+};
+
+static struct clksrc_sources clkset_sclk_spdif = {
+	.sources	= clkset_sclk_spdif_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_spdif_list),
+};
+
 static struct clksrc_clk clksrcs[] = {
 	{
 		.clk	= {
@@ -560,6 +673,15 @@ static struct clksrc_clk clksrcs[] = {
 		},
 		.sources = &clkset_sclk_mixer,
 		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 1 },
+	}, {
+		.clk		= {
+			.name		= "sclk_spdif",
+			.id		= -1,
+			.enable		= s5pv210_clk_mask0_ctrl,
+			.ctrlbit	= (1 << 27),
+		},
+		.sources = &clkset_sclk_spdif,
+		.reg_src = { .reg = S5P_CLK_SRC6, .shift = 12, .size = 2 },
 	},
 };
 
@@ -658,6 +780,9 @@ static struct clk *clks[] __initdata = {
 	&clk_sclk_hdmiphy,
 	&clk_sclk_usbphy0,
 	&clk_sclk_usbphy1,
+	&clk_pcmcdclk0,
+	&clk_pcmcdclk1,
+	&clk_pcmcdclk2,
 };
 
 void __init s5pv210_register_clocks(void)
-- 
1.6.2.5
