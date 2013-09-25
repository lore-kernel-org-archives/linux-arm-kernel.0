From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 25 Sep 2013 13:24:18 +0200
Subject: [PATCH] ARM: mvebu: fix gated clock documentation
Message-ID: <1380108258-14739-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gated clock documentation referred only to the Orion SoC whereas
it also applied for the Armada 370/XP SoC. This commit updates the
introduction text and also the list of the compatible strings.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index cffc93d..fc2910f 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -1,10 +1,10 @@
-* Gated Clock bindings for Marvell Orion SoCs
+* Gated Clock bindings for Marvell EBU SoCs
 
-Marvell Dove and Kirkwood allow some peripheral clocks to be gated to save
-some power. The clock consumer should specify the desired clock by having
-the clock ID in its "clocks" phandle cell. The clock ID is directly mapped to
-the corresponding clock gating control bit in HW to ease manual clock lookup
-in datasheet.
+Marvell Armada 370/XP, Dove and Kirkwood allow some peripheral clocks to be
+gated to save some power. The clock consumer should specify the desired clock
+by having the clock ID in its "clocks" phandle cell. The clock ID is directly
+mapped to the corresponding clock gating control bit in HW to ease manual clock
+lookup in datasheet.
 
 The following is a list of provided IDs for Armada 370:
 ID	Clock	Peripheral
@@ -94,6 +94,8 @@ ID	Clock	Peripheral
 
 Required properties:
 - compatible : shall be one of the following:
+	"marvell,armada-370-gating-clock" - for Armada 370 SoC clock gating
+	"marvell,armada-xp-gating-clock" - for Armada XP SoC clock gating
 	"marvell,dove-gating-clock" - for Dove SoC clock gating
 	"marvell,kirkwood-gating-clock" - for Kirkwood SoC clock gating
 - reg : shall be the register address of the Clock Gating Control register
-- 
1.8.1.2
