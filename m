From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:25 +0200
Subject: [PATCH 13/16] deps: WIP: omap: annotate some initcalls
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-14-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WIP means Work In Progress.

Change some omap drivers to offer annotated initcalls.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/common/edma.c                 | 2 +-
 drivers/bus/omap_l3_smx.c              | 2 +-
 drivers/dma/omap-dma.c                 | 2 +-
 drivers/gpio/gpio-twl4030.c            | 2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 2 +-
 drivers/i2c/busses/i2c-omap.c          | 2 +-
 drivers/iommu/omap-iommu.c             | 2 +-
 drivers/mailbox/omap-mailbox.c         | 2 +-
 drivers/memory/omap-gpmc.c             | 2 +-
 drivers/mfd/omap-usb-host.c            | 2 +-
 drivers/mfd/omap-usb-tll.c             | 2 +-
 drivers/mfd/tps65217.c                 | 2 +-
 drivers/net/ethernet/ti/cpsw.c         | 2 +-
 drivers/net/ethernet/ti/davinci_mdio.c | 2 +-
 drivers/phy/phy-twl4030-usb.c          | 2 +-
 drivers/regulator/twl-regulator.c      | 2 +-
 drivers/tty/serial/omap-serial.c       | 2 +-
 drivers/usb/host/ehci-omap.c           | 2 +-
 drivers/usb/host/ohci-omap3.c          | 2 +-
 drivers/usb/musb/omap2430.c            | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 873dbfc..29f363c 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1872,5 +1872,5 @@ static int __init edma_init(void)
 {
 	return platform_driver_probe(&edma_driver, edma_probe);
 }
-arch_initcall(edma_init);
+annotated_initcall(arch, edma_init, edma_driver.driver);
 
diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index 360a5c0..e2172b8 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -302,7 +302,7 @@ static int __init omap3_l3_init(void)
 {
 	return platform_driver_register(&omap3_l3_driver);
 }
-postcore_initcall_sync(omap3_l3_init);
+annotated_initcall_sync(postcore, omap3_l3_init, omap3_l3_driver.driver);
 
 static void __exit omap3_l3_exit(void)
 {
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 249445c..0866ae9 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -1285,7 +1285,7 @@ static int omap_dma_init(void)
 {
 	return platform_driver_register(&omap_dma_driver);
 }
-subsys_initcall(omap_dma_init);
+annotated_initcall(subsys, omap_dma_init, omap_dma_driver.driver);
 
 static void __exit omap_dma_exit(void)
 {
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 9e1dbb9..60c0d1a 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -615,7 +615,7 @@ static int __init gpio_twl4030_init(void)
 {
 	return platform_driver_register(&gpio_twl4030_driver);
 }
-subsys_initcall(gpio_twl4030_init);
+annotated_initcall(subsys, gpio_twl4030_init, gpio_twl4030_driver.driver);
 
 static void __exit gpio_twl4030_exit(void)
 {
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 0f283a3..8c50f23 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -715,7 +715,7 @@ static void __exit tilcdc_drm_fini(void)
 	tilcdc_tfp410_fini();
 }
 
-module_init(tilcdc_drm_init);
+annotated_module_init(tilcdc_drm_init, tilcdc_platform_driver.driver);
 module_exit(tilcdc_drm_fini);
 
 MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fc9bf7f..0a5d63b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1541,7 +1541,7 @@ omap_i2c_init_driver(void)
 {
 	return platform_driver_register(&omap_i2c_driver);
 }
-subsys_initcall(omap_i2c_init_driver);
+annotated_initcall(subsys, omap_i2c_init_driver, omap_i2c_driver.driver);
 
 static void __exit omap_i2c_exit_driver(void)
 {
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index a22c33d..cf2ef44 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1406,7 +1406,7 @@ static int __init omap_iommu_init(void)
 	return platform_driver_register(&omap_iommu_driver);
 }
 /* must be ready before omap3isp is probed */
-subsys_initcall(omap_iommu_init);
+annotated_initcall(subsys, omap_iommu_init, omap_iommu_driver.driver);
 
 static void __exit omap_iommu_exit(void)
 {
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index a3dbfd9..ac12306 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -883,7 +883,7 @@ static int __init omap_mbox_init(void)
 
 	return platform_driver_register(&omap_mbox_driver);
 }
-subsys_initcall(omap_mbox_init);
+annotated_initcall(subsys, omap_mbox_init, omap_mbox_driver.driver);
 
 static void __exit omap_mbox_exit(void)
 {
diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 9426276..65b0138 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2217,7 +2217,7 @@ static __exit void gpmc_exit(void)
 
 }
 
-postcore_initcall(gpmc_init);
+annotated_initcall(postcore, gpmc_init, gpmc_driver.driver);
 module_exit(gpmc_exit);
 
 static irqreturn_t gpmc_handle_irq(int irq, void *dev)
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 1d924d1..c996f45 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -896,7 +896,7 @@ static int __init omap_usbhs_drvinit(void)
  * This usbhs core driver should be initialized after
  * usb tll driver
  */
-fs_initcall_sync(omap_usbhs_drvinit);
+annotated_initcall_sync(fs, omap_usbhs_drvinit, usbhs_omap_driver.driver);
 
 static void __exit omap_usbhs_drvexit(void)
 {
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index b7b3e8e..ac5d393 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -475,7 +475,7 @@ static int __init omap_usbtll_drvinit(void)
  * The usbtll driver should be initialized before
  * the usbhs core driver probe function is called.
  */
-fs_initcall(omap_usbtll_drvinit);
+annotated_initcall(fs, omap_usbtll_drvinit, usbtll_omap_driver.driver);
 
 static void __exit omap_usbtll_drvexit(void)
 {
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 7d1cfc1..386dd15 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -260,7 +260,7 @@ static int __init tps65217_init(void)
 {
 	return i2c_add_driver(&tps65217_driver);
 }
-subsys_initcall(tps65217_init);
+annotated_initcall(subsys, tps65217_init, tps65217_driver.driver);
 
 static void __exit tps65217_exit(void)
 {
diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index d155bf2..6b772b5 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2524,7 +2524,7 @@ static int __init cpsw_init(void)
 {
 	return platform_driver_register(&cpsw_driver);
 }
-late_initcall(cpsw_init);
+annotated_initcall(late, cpsw_init, cpsw_driver.driver);
 
 static void __exit cpsw_exit(void)
 {
diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index c00084d..32e0269 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -493,7 +493,7 @@ static int __init davinci_mdio_init(void)
 {
 	return platform_driver_register(&davinci_mdio_driver);
 }
-device_initcall(davinci_mdio_init);
+annotated_initcall(device, davinci_mdio_init, davinci_mdio_driver.driver);
 
 static void __exit davinci_mdio_exit(void)
 {
diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 3a707dd..b3bba7a 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -801,7 +801,7 @@ static int __init twl4030_usb_init(void)
 {
 	return platform_driver_register(&twl4030_usb_driver);
 }
-subsys_initcall(twl4030_usb_init);
+annotated_initcall(subsys, twl4030_usb_init, twl4030_usb_driver.driver);
 
 static void __exit twl4030_usb_exit(void)
 {
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 955a6fb..356066b 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -1229,7 +1229,7 @@ static int __init twlreg_init(void)
 {
 	return platform_driver_register(&twlreg_driver);
 }
-subsys_initcall(twlreg_init);
+annotated_initcall(subsys, twlreg_init, twlreg_driver.driver);
 
 static void __exit twlreg_exit(void)
 {
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7a2172b..b78b4d7 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1889,7 +1889,7 @@ static void __exit serial_omap_exit(void)
 	uart_unregister_driver(&serial_omap_reg);
 }
 
-module_init(serial_omap_init);
+annotated_module_init(serial_omap_init, serial_omap_driver.driver);
 module_exit(serial_omap_exit);
 
 MODULE_DESCRIPTION("OMAP High Speed UART driver");
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index a24720b..1e4076d 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -310,7 +310,7 @@ static int __init ehci_omap_init(void)
 	ehci_init_driver(&ehci_omap_hc_driver, &ehci_omap_overrides);
 	return platform_driver_register(&ehci_hcd_omap_driver);
 }
-module_init(ehci_omap_init);
+annotated_module_init(ehci_omap_init, ehci_hcd_omap_driver.driver);
 
 static void __exit ehci_omap_cleanup(void)
 {
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index ec15aeb..bcb1a1b 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -197,7 +197,7 @@ static int __init ohci_omap3_init(void)
 	ohci_init_driver(&ohci_omap3_hc_driver, NULL);
 	return platform_driver_register(&ohci_hcd_omap3_driver);
 }
-module_init(ohci_omap3_init);
+annotated_module_init(ohci_omap3_init, ohci_hcd_omap3_driver.driver);
 
 static void __exit ohci_omap3_cleanup(void)
 {
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 70f2b8a..6a13f0b 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -725,7 +725,7 @@ static int __init omap2430_init(void)
 {
 	return platform_driver_register(&omap2430_driver);
 }
-subsys_initcall(omap2430_init);
+annotated_initcall(subsys, omap2430_init, omap2430_driver.driver);
 
 static void __exit omap2430_exit(void)
 {
-- 
2.1.0
