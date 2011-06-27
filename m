From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 27 Jun 2011 17:12:11 -0300
Subject: [PATCH 4/4] ARM: mx53: Add keypad support
In-Reply-To: <1309205531-18103-3-git-send-email-fabio.estevam@freescale.com>
References: <1309205531-18103-1-git-send-email-fabio.estevam@freescale.com>
	<1309205531-18103-2-git-send-email-fabio.estevam@freescale.com>
	<1309205531-18103-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1309205531-18103-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c             |    1 +
 arch/arm/mach-mx5/devices-imx53.h               |    4 ++++
 arch/arm/plat-mxc/devices/platform-imx-keypad.c |    5 +++++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 96d323a..bcb5c91 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1493,6 +1493,7 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
+	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index b8a492f..c27fe8b 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -36,3 +36,7 @@ extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[];
 extern const struct imx_imx_ssi_data imx53_imx_ssi_data[];
 #define imx53_add_imx_ssi(id, pdata)	\
 	imx_add_imx_ssi(&imx53_imx_ssi_data[id], pdata)
+
+extern const struct imx_imx_keypad_data imx53_imx_keypad_data;
+#define imx53_add_imx_keypad(pdata)	\
+	imx_add_imx_keypad(&imx53_imx_keypad_data, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-keypad.c b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
index 2636611..479c3e9 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-keypad.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-keypad.c
@@ -46,6 +46,11 @@ const struct imx_imx_keypad_data imx51_imx_keypad_data __initconst =
 	imx_imx_keypad_data_entry_single(MX51, SZ_16);
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_imx_keypad_data imx53_imx_keypad_data __initconst =
+	imx_imx_keypad_data_entry_single(MX53, SZ_16);
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_imx_keypad(
 		const struct imx_imx_keypad_data *data,
 		const struct matrix_keymap_data *pdata)
-- 
1.6.0.4
