From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 13 Aug 2013 11:07:20 +0530
Subject: [PATCH 1/2] extcon: palmas: Added a new compatible type *ti,
 palmas-usb-vid*
In-Reply-To: <1376302675-15795-1-git-send-email-kishon@ti.com>
References: <1376302675-15795-1-git-send-email-kishon@ti.com>
Message-ID: <1376372241-15573-1-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Palmas device contains only a USB VID detector, so added a
compatible type *ti,palmas-usb-vid*. Dint remove the existing compatible
types for backward compatibility.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/extcon/extcon-twl.txt |    3 ++-
 drivers/extcon/extcon-palmas.c                          |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-twl.txt b/Documentation/devicetree/bindings/extcon/extcon-twl.txt
index 58f531a..5be4afc 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-twl.txt
+++ b/Documentation/devicetree/bindings/extcon/extcon-twl.txt
@@ -2,7 +2,8 @@ EXTCON FOR TWL CHIPS
 
 PALMAS USB COMPARATOR
 Required Properties:
- - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb"
+ - compatible : Should be "ti,palmas-usb" or "ti,twl6035-usb" or
+   "ti,palmas-usb-vid".
  - vbus-supply : phandle to the regulator device tree node.
 
 Optional Properties:
diff --git a/drivers/extcon/extcon-palmas.c b/drivers/extcon/extcon-palmas.c
index b752a0a..4f83fae 100644
--- a/drivers/extcon/extcon-palmas.c
+++ b/drivers/extcon/extcon-palmas.c
@@ -223,6 +223,7 @@ static int palmas_usb_remove(struct platform_device *pdev)
 
 static struct of_device_id of_palmas_match_tbl[] = {
 	{ .compatible = "ti,palmas-usb", },
+	{ .compatible = "ti,palmas-usb-vid", },
 	{ .compatible = "ti,twl6035-usb", },
 	{ /* end */ }
 };
-- 
1.7.10.4
