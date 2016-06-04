From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:10:01 +0300
Subject: [PATCH 09/22] input: clps711x-keypad: Changing the compatibility
 string to match with the smallest supported chip
In-Reply-To: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
References: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
Message-ID: <1465024214-22120-10-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the compatibility string to match with the smallest
supported chip (EP7209). Since the DT-support for this CPU is not yet
announced, this change is safe.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/input/clps711x-keypad.txt | 4 ++--
 drivers/input/keyboard/clps711x-keypad.c                    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/clps711x-keypad.txt b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
index e68d2bb..3eed881 100644
--- a/Documentation/devicetree/bindings/input/clps711x-keypad.txt
+++ b/Documentation/devicetree/bindings/input/clps711x-keypad.txt
@@ -1,7 +1,7 @@
 * Cirrus Logic CLPS711X matrix keypad device tree bindings
 
 Required Properties:
-- compatible:    Shall contain "cirrus,clps711x-keypad".
+- compatible:    Shall contain "cirrus,ep7209-keypad".
 - row-gpios:     List of GPIOs used as row lines.
 - poll-interval: Poll interval time in milliseconds.
 - linux,keymap:  The definition can be found at
@@ -12,7 +12,7 @@ Optional Properties:
 
 Example:
 	keypad {
-		compatible = "cirrus,ep7312-keypad", "cirrus,clps711x-keypad";
+		compatible = "cirrus,ep7312-keypad", "cirrus,ep7209-keypad";
 		autorepeat;
 		poll-interval = <120>;
 		row-gpios = <&porta 0 0>,
diff --git a/drivers/input/keyboard/clps711x-keypad.c b/drivers/input/keyboard/clps711x-keypad.c
index b637f1a..997e3e9 100644
--- a/drivers/input/keyboard/clps711x-keypad.c
+++ b/drivers/input/keyboard/clps711x-keypad.c
@@ -101,7 +101,7 @@ static int clps711x_keypad_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->syscon =
-		syscon_regmap_lookup_by_compatible("cirrus,clps711x-syscon1");
+		syscon_regmap_lookup_by_compatible("cirrus,ep7209-syscon1");
 	if (IS_ERR(priv->syscon))
 		return PTR_ERR(priv->syscon);
 
@@ -181,7 +181,7 @@ static int clps711x_keypad_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id clps711x_keypad_of_match[] = {
-	{ .compatible = "cirrus,clps711x-keypad", },
+	{ .compatible = "cirrus,ep7209-keypad", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clps711x_keypad_of_match);
-- 
2.4.9
