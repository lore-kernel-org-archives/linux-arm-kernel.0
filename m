From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 20 May 2017 16:12:49 +0200
Subject: [PATCH v2 1/2] phy: meson8b-usb2: add support for the USB PHY on
 Meson8 SoCs
In-Reply-To: <20170520141250.27388-1-martin.blumenstingl@googlemail.com>
References: <20170506173625.19501-1-martin.blumenstingl@googlemail.com>
 <20170520141250.27388-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170520141250.27388-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Meson8 uses the same USB PHY as found on the Meson8b and GXBB SoCs. Add
a new of_device_id to indicate this. Also update the Kconfig option and
MODULE_DESCRIPTION accordingly.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/phy/amlogic/Kconfig            | 6 +++---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index 2044211c5b86..cb8f4501652b 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -2,15 +2,15 @@
 # Phy drivers for Amlogic platforms
 #
 config PHY_MESON8B_USB2
-	tristate "Meson8b and GXBB USB2 PHY driver"
+	tristate "Meson8, Meson8b and GXBB USB2 PHY driver"
 	default ARCH_MESON
 	depends on OF && (ARCH_MESON || COMPILE_TEST)
 	depends on USB_SUPPORT
 	select USB_COMMON
 	select GENERIC_PHY
 	help
-	  Enable this to support the Meson USB2 PHYs found in Meson8b
-	  and GXBB SoCs.
+	  Enable this to support the Meson USB2 PHYs found in Meson8,
+	  Meson8b and GXBB SoCs.
 	  If unsure, say N.
 
 config PHY_MESON_GXL_USB2
diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 30f56a6a411f..9c01b7e19b06 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -1,5 +1,5 @@
 /*
- * Meson8b and GXBB USB2 PHY driver
+ * Meson8, Meson8b and GXBB USB2 PHY driver
  *
  * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
  *
@@ -266,6 +266,7 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id phy_meson8b_usb2_of_match[] = {
+	{ .compatible = "amlogic,meson8-usb2-phy", },
 	{ .compatible = "amlogic,meson8b-usb2-phy", },
 	{ .compatible = "amlogic,meson-gxbb-usb2-phy", },
 	{ },
@@ -282,5 +283,5 @@ static struct platform_driver phy_meson8b_usb2_driver = {
 module_platform_driver(phy_meson8b_usb2_driver);
 
 MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
-MODULE_DESCRIPTION("Meson8b and GXBB USB2 PHY driver");
+MODULE_DESCRIPTION("Meson8, Meson8b and GXBB USB2 PHY driver");
 MODULE_LICENSE("GPL");
-- 
2.13.0
