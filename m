From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  6 May 2017 19:36:25 +0200
Subject: [PATCH] phy: meson8b-usb2: add support for the USB PHY on Meson8 SoCs
Message-ID: <20170506173625.19501-1-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Meson8 uses the same USB PHY as found on the Meson8b and GXBB SoCs. Add
a new of_device_id to indicate this. Also update the documentation
(devicetree binding, Kconfig and MODULE_DESCRIPTION) accordingly.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt | 3 ++-
 drivers/phy/Kconfig                                        | 4 ++--
 drivers/phy/phy-meson8b-usb2.c                             | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt b/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
index 5fa73b9d20f5..d81d73aea608 100644
--- a/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
@@ -1,7 +1,8 @@
-* Amlogic Meson8b and GXBB USB2 PHY
+* Amlogic Meson8, Meson8b and GXBB USB2 PHY
 
 Required properties:
 - compatible:	Depending on the platform this should be one of:
+	"amlogic,meson8-usb2-phy"
 	"amlogic,meson8b-usb2-phy"
 	"amlogic,meson-gxbb-usb2-phy"
 - reg:		The base address and length of the registers
diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 005cadb7a3f8..0d3e5099ff6a 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -507,8 +507,8 @@ config PHY_MESON8B_USB2
 	select USB_COMMON
 	select GENERIC_PHY
 	help
-	  Enable this to support the Meson USB2 PHYs found in Meson8b
-	  and GXBB SoCs.
+	  Enable this to support the Meson USB2 PHYs found in Meson8,
+	  Meson8b and GXBB SoCs.
 	  If unsure, say N.
 
 endmenu
diff --git a/drivers/phy/phy-meson8b-usb2.c b/drivers/phy/phy-meson8b-usb2.c
index d75004e69b65..a8012bb1d1c5 100644
--- a/drivers/phy/phy-meson8b-usb2.c
+++ b/drivers/phy/phy-meson8b-usb2.c
@@ -1,5 +1,5 @@
 /*
- * Meson8b and GXBB USB2 PHY driver
+ * Meson8, Meson8b and GXBB USB2 PHY driver
  *
  * Copyright (C) 2016 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
  *
@@ -285,6 +285,7 @@ static int phy_meson8b_usb2_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id phy_meson8b_usb2_of_match[] = {
+	{ .compatible = "amlogic,meson8-usb2-phy", },
 	{ .compatible = "amlogic,meson8b-usb2-phy", },
 	{ .compatible = "amlogic,meson-gxbb-usb2-phy", },
 	{ },
@@ -301,5 +302,5 @@ static struct platform_driver phy_meson8b_usb2_driver = {
 module_platform_driver(phy_meson8b_usb2_driver);
 
 MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
-MODULE_DESCRIPTION("Meson8b and GXBB USB2 PHY driver");
+MODULE_DESCRIPTION("Meson8, Meson8b and GXBB USB2 PHY driver");
 MODULE_LICENSE("GPL");
-- 
2.12.2
