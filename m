From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Aug 2013 09:32:54 +0200
Subject: [PATCH v7] ARM: dts: mvebu: Introduce a new compatible string for
 mv64xxx-i2c
Message-ID: <1377243174-15877-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv64xxx-i2c embedded in the Armada XP have a new feature to
offload i2c transaction. This new version of the IP come also with
some errata. This lead to the introduction to a another compatible
string.

This commit updates the Device Tree binding documentation accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Changelog v6 -> v7:

- only keep "marvell,mv7230-i2c" for compatible name

- replace "For a controller which support the I2C Transaction
  Generator" by "For the Armada XP" in the examples

 Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
index 6113f92..73cdc03 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
@@ -5,6 +5,7 @@ Required properties :
 
  - reg             : Offset and length of the register set for the device
  - compatible      : Should be "marvell,mv64xxx-i2c" or "allwinner,sun4i-i2c"
+                     or "marvell,mv7230-i2c"
  - interrupts      : The interrupt number
 
 Optional properties :
@@ -20,3 +21,12 @@ Examples:
 		interrupts = <29>;
 		clock-frequency = <100000>;
 	};
+
+For the Armada XP:
+
+	i2c at 11000 {
+		compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
+		reg = <0x11000 0x100>;
+		interrupts = <29>;
+		clock-frequency = <100000>;
+	};
-- 
1.8.1.2
