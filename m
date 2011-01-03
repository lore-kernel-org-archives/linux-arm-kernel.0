From: iban@fqingenieria.es (FQ | Iban Cerro)
Date: Mon, 3 Jan 2011 10:13:40 +0100 (CET)
Subject: [PATCH 04/04] ARM i.MX25 Add SIM 3DS PDK
Message-ID: <26139.212.121.242.58.1294046020.squirrel@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Includes driver into the corresponding platform

Signed-off-by: Iban Cerro Galvez <iban@fqingenieria.es>
---
 arch/arm/mach-imx/mach-mx25_3ds.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c
b/arch/arm/mach-imx/mach-mx25_3ds.c
index 8b8e75b..2933452 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -102,6 +102,18 @@ static iomux_v3_cfg_t mx25pdk_pads[] = {
 	MX25_PAD_SD1_DATA1__SD1_DATA1,
 	MX25_PAD_SD1_DATA2__SD1_DATA2,
 	MX25_PAD_SD1_DATA3__SD1_DATA3,
+
+	/* SIM1 */
+	MX25_PAD_CSI_D4__SIM1_VEN0,
+	MX25_PAD_CSI_D5__SIM1_TX0,
+	MX25_PAD_CSI_D3__SIM1_RST0,
+	MX25_PAD_CSI_D2__SIM1_CLK0,
+
+	/* SIM2 */
+	MX25_PAD_CSI_MCLK__SIM2_VEN0,
+	MX25_PAD_CSI_VSYNC__SIM2_TX0,
+	MX25_PAD_CSI_D9__SIM2_RST0,
+	MX25_PAD_CSI_D8__SIM2_CLK0,
 };

 static const struct fec_platform_data mx25_fec_pdata __initconst = {
@@ -160,6 +172,27 @@ static const struct imx_fb_platform_data
mx25pdk_fb_pdata __initconst = {
 	.dmacr		= 0x00020010,
 };

+static struct mxc_sim_platform_data mx25_sim_data[] ={
+	{
+	.clk_rate = 5000000,
+	.clock_sim = "mxc-sim.0",
+	.power_sim = NULL,
+	.init = NULL,
+	.exit = NULL,
+	.detect = 1,
+	.sim_number = 0,
+	},
+	{
+	.clk_rate = 5000000,
+	.clock_sim = "mxc-sim.1",
+	.power_sim = NULL,
+	.init = NULL,
+	.exit = NULL,
+	.detect = 1,
+	.sim_number = 1,
+	}
+};
+
 static const uint32_t mx25pdk_keymap[] = {
 	KEY(0, 0, KEY_UP),
 	KEY(0, 1, KEY_DOWN),
@@ -201,6 +234,8 @@ static void __init mx25pdk_init(void)
 	imx25_add_imx_keypad(&mx25pdk_keymap_data);

 	imx25_add_sdhci_esdhc_imx(0, NULL);
+	imx25_add_mxc_sim0(&mx25_sim_data[0]);
+	imx25_add_mxc_sim1(&mx25_sim_data[1]);
 }

 static void __init mx25pdk_timer_init(void)
-- 
1.5.4.3
