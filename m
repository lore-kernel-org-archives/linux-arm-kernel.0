From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Mar 2016 12:53:29 +0100
Subject: [PATCH v2] Documentation: devicetree: Clean up gpio-keys example
Message-ID: <1458129209-15449-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop #address-cells and #size-cells, which are not required by the
gpio-keys binding documentation, as button sub-nodes are not devices.

Rename sub-nodes to avoid new dtc unit address warnings when copied.

While at it, adopt the dashes convention for the node name.

Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
Cc: Julien Chauveau <chauveau.julien@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Changed node name from underscore to dash
 * Inserted white lines
 * Renamed sub-nodes (Geert, Julien)
 
 Documentation/devicetree/bindings/input/gpio-keys.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index 21641236c095..a94940481e55 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -32,17 +32,17 @@ Optional subnode-properties:
 
 Example nodes:
 
-	gpio_keys {
+	gpio-keys {
 			compatible = "gpio-keys";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			autorepeat;
-			button at 21 {
+
+			up {
 				label = "GPIO Key UP";
 				linux,code = <103>;
 				gpios = <&gpio1 0 1>;
 			};
-			button at 22 {
+
+			down {
 				label = "GPIO Key DOWN";
 				linux,code = <108>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
-- 
2.6.2
