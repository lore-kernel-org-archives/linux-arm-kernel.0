From: jason.hui@linaro.org (Jason Liu)
Date: Fri, 12 Aug 2011 15:04:44 +0800
Subject: [PATCH 1/2] ARM: i.MX53: Add NAND device support
In-Reply-To: <1313132685-10440-1-git-send-email-jason.hui@linaro.org>
References: <1313132685-10440-1-git-send-email-jason.hui@linaro.org>
Message-ID: <1313132685-10440-2-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Liu <jason.hui@linaro.org>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c           |    1 +
 arch/arm/mach-mx5/devices-imx53.h             |    4 ++++
 arch/arm/plat-mxc/devices/platform-mxc_nand.c |    5 +++++
 3 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index f7bf996..aa410bd 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1507,6 +1507,7 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
 	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
+	_REGISTER_CLOCK("mxc_nand", NULL, nfc_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index c27fe8b..a1267f0 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -40,3 +40,7 @@ extern const struct imx_imx_ssi_data imx53_imx_ssi_data[];
 extern const struct imx_imx_keypad_data imx53_imx_keypad_data;
 #define imx53_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx53_imx_keypad_data, pdata)
+
+extern const struct imx_mxc_nand_data imx53_mxc_nand_data __initconst;
+#define imx53_add_mxc_nand(pdata)	\
+	imx_add_mxc_nand(&imx53_mxc_nand_data, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
index 1568f39..3103b72 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_nand.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
@@ -56,6 +56,11 @@ const struct imx_mxc_nand_data imx51_mxc_nand_data __initconst =
 	imx_mxc_nandv3_data_entry_single(MX51, SZ_16K);
 #endif
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_mxc_nand_data imx53_mxc_nand_data __initconst =
+	imx_mxc_nandv3_data_entry_single(MX53, SZ_16K);
+#endif
+
 struct platform_device *__init imx_add_mxc_nand(
 		const struct imx_mxc_nand_data *data,
 		const struct mxc_nand_platform_data *pdata)
-- 
1.7.4.1
