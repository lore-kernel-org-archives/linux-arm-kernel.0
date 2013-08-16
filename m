From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Aug 2013 15:50:48 +0530
Subject: [PATCH v2] extcon: palmas: Modified the compatible type to *ti,
 palmas-usb-vid*
Message-ID: <1376648448-27447-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Palmas device contains only a USB VID detector, so modified the
compatible type to *ti,palmas-usb-vid*.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v1:
* removed the existing compatible types and changed it to *ti,palmas-usb-vid*

 Documentation/devicetree/bindings/extcon/extcon-palmas.txt |    4 ++--
 drivers/extcon/extcon-palmas.c                             |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
index 7dab6a8..00859f6 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
+++ b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
@@ -2,7 +2,7 @@ EXTCON FOR PALMAS/TWL CHIPS
 
 PALMAS USB COMPARATOR
 Required Properties:
- - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
+ - compatible : Should be "ti,palmas-usb-vid".
 
 Optional Properties:
  - ti,wakeup : To enable the wakeup comparator in probe
@@ -10,6 +10,6 @@ Optional Properties:
  - ti,enable-vbus-detection: Perform VBUS detection.
 
 palmas-usb {
-       compatible = "ti,twl6035-usb", "ti,palmas-usb";
+       compatible = "ti,palmas-usb-vid";
        ti,wakeup;
 };
diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 89fdd05..f3ed2d7 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -267,8 +267,7 @@ static const struct dev_pm_ops palmas_pm_ops = {
 };
 
 static struct of_device_id of_palmas_match_tbl[] = {
-	{ .compatible = "ti,palmas-usb", },
-	{ .compatible = "ti,twl6035-usb", },
+	{ .compatible = "ti,palmas-usb-vid", },
 	{ /* end */ }
 };
 
-- 
1.7.10.4
