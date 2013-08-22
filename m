From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 22 Aug 2013 10:53:07 +0530
Subject: [PATCH v3] extcon: palmas: Added a new compatible type *ti,
 palmas-usb-vid*
Message-ID: <1377148987-21831-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Palmas device contains only a USB VID detector, so added a
compatible type *ti,palmas-usb-vid*. Didn't remove the existing compatible
types for backward compatibility.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from [1]:
* Since the old compatible values will be in 3.11 kernel, we shouldn't remove
the old compatible values. So retain the old compatible values.

[1] -> http://www.spinics.net/lists/linux-omap/msg95843.html

 Documentation/devicetree/bindings/extcon/extcon-palmas.txt |    3 ++-
 drivers/extcon/extcon-palmas.c                             |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
index 7dab6a8..dc5fab3 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
+++ b/Documentation/devicetree/bindings/extcon/extcon-palmas.txt
@@ -2,7 +2,8 @@ EXTCON FOR PALMAS/TWL CHIPS
 
 PALMAS USB COMPARATOR
 Required Properties:
- - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
+ - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb" or
+   "ti,palmas-usb-vid".
 
 Optional Properties:
  - ti,wakeup : To enable the wakeup comparator in probe
diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index 89fdd05..9672f31 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -268,6 +268,7 @@ static const struct dev_pm_ops palmas_pm_ops = {
 
 static struct of_device_id of_palmas_match_tbl[] = {
 	{ .compatible = "ti,palmas-usb", },
+	{ .compatible = "ti,palmas-usb-vid", },
 	{ .compatible = "ti,twl6035-usb", },
 	{ /* end */ }
 };
-- 
1.7.10.4
