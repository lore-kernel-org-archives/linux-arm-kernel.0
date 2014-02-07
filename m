From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Feb 2014 22:20:39 +0100
Subject: [PATCH v2 1/2] misc: eeprom: sunxi: Change compatibles
In-Reply-To: <1391808040-29814-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391808040-29814-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391808040-29814-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A10 compatibles were following a slightly different compatible
patterns than the rest of the SoCs for historical reasons. Change the compatibles
to match the other pattern in the SID driver for consistency.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt | 4 ++--
 drivers/misc/eeprom/sunxi_sid.c                                | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt
index 68ba372..fabdf64 100644
--- a/Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/misc/allwinner,sunxi-sid.txt
@@ -1,12 +1,12 @@
 Allwinner sunxi-sid
 
 Required properties:
-- compatible: "allwinner,sun4i-sid" or "allwinner,sun7i-a20-sid".
+- compatible: "allwinner,sun4i-a10-sid" or "allwinner,sun7i-a20-sid"
 - reg: Should contain registers location and length
 
 Example for sun4i:
 	sid at 01c23800 {
-		compatible = "allwinner,sun4i-sid";
+		compatible = "allwinner,sun4i-a10-sid";
 		reg = <0x01c23800 0x10>
 	};
 
diff --git a/drivers/misc/eeprom/sunxi_sid.c b/drivers/misc/eeprom/sunxi_sid.c
index 9c34e57..bed0d79 100644
--- a/drivers/misc/eeprom/sunxi_sid.c
+++ b/drivers/misc/eeprom/sunxi_sid.c
@@ -96,7 +96,7 @@ static int sunxi_sid_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sunxi_sid_of_match[] = {
-	{ .compatible = "allwinner,sun4i-sid", .data = (void *)16},
+	{ .compatible = "allwinner,sun4i-a10-sid", .data = (void *)16},
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = (void *)512},
 	{/* sentinel */},
 };
-- 
1.8.4.2
