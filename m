From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 6 Apr 2011 13:05:26 -0300
Subject: [PATCH] ARM: mx51: Remove imx51_add_gpio_keys
Message-ID: <1302105926-20574-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need for using a MX51-specific version of imx_add_gpio_keys.

Remove imx51_add_gpio_keys and use imx_add_gpio_keys instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c |    2 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c |    2 +-
 arch/arm/mach-mx5/devices-imx51.h      |    2 --
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index bea4e41..3ce3806 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -361,7 +361,7 @@ static void __init mx51_babbage_init(void)
 
 	/* Set the PAD settings for the pwr key. */
 	mxc_iomux_v3_setup_pad(power_key);
-	imx51_add_gpio_keys(&imx_button_data);
+	imx_add_gpio_keys(&imx_button_data);
 
 	imx51_add_imx_i2c(0, &babbage_i2c_data);
 	imx51_add_imx_i2c(1, &babbage_i2c_data);
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index acab191..5a36862 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -252,7 +252,7 @@ static void __init mx51_efikamx_init(void)
 	}
 
 	platform_device_register(&mx51_efikamx_leds_device);
-	imx51_add_gpio_keys(&mx51_efikamx_powerkey_data);
+	imx_add_gpio_keys(&mx51_efikamx_powerkey_data);
 
 	if (system_rev == 0x11) {
 		gpio_request(EFIKAMX_RESET1_1, "reset");
diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
index db04ce8..01bece0 100644
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
@@ -260,7 +260,7 @@ static void __init efikasb_board_init(void)
 	imx51_add_sdhci_esdhc_imx(1, NULL);
 
 	platform_device_register(&mx51_efikasb_leds_device);
-	imx51_add_gpio_keys(&mx51_efikasb_keys_data);
+	imx_add_gpio_keys(&mx51_efikasb_keys_data);
 
 }
 
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 7fff485..25ce922 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -13,8 +13,6 @@ extern const struct imx_fec_data imx51_fec_data __initconst;
 #define imx51_add_fec(pdata)	\
 	imx_add_fec(&imx51_fec_data, pdata)
 
-#define imx51_add_gpio_keys(pdata) imx_add_gpio_keys(pdata)
-
 extern const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst;
 #define imx51_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx51_imx_i2c_data[id], pdata)
-- 
1.6.0.4
