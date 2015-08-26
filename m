From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:24 +0200
Subject: [PATCH 12/16] deps: WIP: imx: annotate some initcalls
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-13-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WIP means Work In Progress.

Change some imx drivers to offer annotated initcalls.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/mach-imx/gpc.c                   | 2 +-
 arch/arm/mach-imx/mmdc.c                  | 2 +-
 drivers/dma/mxs-dma.c                     | 2 +-
 drivers/gpio/gpio-mxc.c                   | 2 +-
 drivers/i2c/busses/i2c-imx.c              | 2 +-
 drivers/pinctrl/freescale/pinctrl-imx6q.c | 2 +-
 drivers/power/reset/imx-snvs-poweroff.c   | 2 +-
 drivers/regulator/anatop-regulator.c      | 3 ++-
 drivers/tty/serial/imx.c                  | 2 +-
 drivers/usb/phy/phy-mxs-usb.c             | 2 +-
 sound/soc/fsl/imx-audmux.c                | 2 +-
 11 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 8c4467f..3802614 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -468,4 +468,4 @@ static int __init imx_pgc_init(void)
 {
 	return platform_driver_register(&imx_gpc_driver);
 }
-subsys_initcall(imx_pgc_init);
+annotated_initcall(subsys, imx_pgc_init, imx_gpc_driver.driver);
diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index db9621c..cf84c03 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -87,4 +87,4 @@ static int __init imx_mmdc_init(void)
 {
 	return platform_driver_register(&imx_mmdc_driver);
 }
-postcore_initcall(imx_mmdc_init);
+annotated_initcall(postcore, imx_mmdc_init, imx_mmdc_driver.driver);
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 60de352..5bfa232 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -884,4 +884,4 @@ static int __init mxs_dma_module_init(void)
 {
 	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
 }
-subsys_initcall(mxs_dma_module_init);
+annotated_initcall(subsys, mxs_dma_module_init, mxs_dma_driver.driver);
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index ec1eb1b..0a22a62 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -506,7 +506,7 @@ static int __init gpio_mxc_init(void)
 {
 	return platform_driver_register(&mxc_gpio_driver);
 }
-postcore_initcall(gpio_mxc_init);
+annotated_initcall(postcore, gpio_mxc_init, mxc_gpio_driver.driver);
 
 MODULE_AUTHOR("Freescale Semiconductor, "
 	      "Daniel Mack <danielncaiaq.de>, "
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 785aa67..c20d03c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1110,7 +1110,7 @@ static int __init i2c_adap_imx_init(void)
 {
 	return platform_driver_register(&i2c_imx_driver);
 }
-subsys_initcall(i2c_adap_imx_init);
+annotated_initcall(subsys, i2c_adap_imx_init, i2c_imx_driver.driver);
 
 static void __exit i2c_adap_imx_exit(void)
 {
diff --git a/drivers/pinctrl/freescale/pinctrl-imx6q.c b/drivers/pinctrl/freescale/pinctrl-imx6q.c
index 4d1fcb8..77a1ffd 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx6q.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx6q.c
@@ -489,7 +489,7 @@ static int __init imx6q_pinctrl_init(void)
 {
 	return platform_driver_register(&imx6q_pinctrl_driver);
 }
-arch_initcall(imx6q_pinctrl_init);
+annotated_initcall(arch, imx6q_pinctrl_init, imx6q_pinctrl_driver.driver);
 
 static void __exit imx6q_pinctrl_exit(void)
 {
diff --git a/drivers/power/reset/imx-snvs-poweroff.c b/drivers/power/reset/imx-snvs-poweroff.c
index ad6ce50..57a06dc 100644
--- a/drivers/power/reset/imx-snvs-poweroff.c
+++ b/drivers/power/reset/imx-snvs-poweroff.c
@@ -63,4 +63,4 @@ static int __init imx_poweroff_init(void)
 {
 	return platform_driver_register(&imx_poweroff_driver);
 }
-device_initcall(imx_poweroff_init);
+annotated_initcall(device, imx_poweroff_init, imx_poweroff_driver.driver);
diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 738adfa..97808da 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -331,7 +331,8 @@ static int __init anatop_regulator_init(void)
 {
 	return platform_driver_register(&anatop_regulator_driver);
 }
-postcore_initcall(anatop_regulator_init);
+annotated_initcall(postcore, anatop_regulator_init,
+					anatop_regulator_driver.driver);
 
 static void __exit anatop_regulator_exit(void)
 {
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 54fdc78..c79e19b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2024,7 +2024,7 @@ static void __exit imx_serial_exit(void)
 	uart_unregister_driver(&imx_reg);
 }
 
-module_init(imx_serial_init);
+annotated_module_init(imx_serial_init, serial_imx_driver.driver);
 module_exit(imx_serial_exit);
 
 MODULE_AUTHOR("Sascha Hauer");
diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 3fcc048..dd2768d 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -577,7 +577,7 @@ static int __init mxs_phy_module_init(void)
 {
 	return platform_driver_register(&mxs_phy_driver);
 }
-postcore_initcall(mxs_phy_module_init);
+annotated_initcall(postcore, mxs_phy_module_init, mxs_phy_driver.driver);
 
 static void __exit mxs_phy_module_exit(void)
 {
diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index fc57da3..19fd729 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -364,7 +364,7 @@ static int __init imx_audmux_init(void)
 {
 	return platform_driver_register(&imx_audmux_driver);
 }
-subsys_initcall(imx_audmux_init);
+annotated_initcall(subsys, imx_audmux_init, imx_audmux_driver.driver);
 
 static void __exit imx_audmux_exit(void)
 {
-- 
2.1.0
