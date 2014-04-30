From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Apr 2014 14:56:40 +0200
Subject: [PATCH 13/15] ARM: dts: kirkwood: set default pinctrl for I2C1 on 6282
In-Reply-To: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1398862602-29595-14-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the only 6282-based Kirkwood boards that use I2C1 are Openblocks
A6/A7. Both use the same default I2C1 pinctrl setting from kirkwood-6282.dtsi.
Move the pinctrl setting to the I2C1 node directly and put a note in front of
the corresponding pinctrl node to overwrite the setting on board level.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/kirkwood-6282.dtsi         | 6 ++++++
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts | 2 --
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts | 2 --
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index b869f48cac02..4680eec990f0 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -68,6 +68,10 @@
 				marvell,function = "sata1";
 			};
 
+			/*
+			 * Default I2C1 pinctrl setting on mpp36/mpp37,
+			 * overwrite marvell,pins on board level if required.
+			 */
 			pmx_twsi1: pmx-twsi1 {
 				marvell,pins = "mpp36", "mpp37";
 				marvell,function = "twsi1";
@@ -101,6 +105,8 @@
 			interrupts = <32>;
 			clock-frequency = <100000>;
 			clocks = <&gate_clk 7>;
+			pinctrl-0 = <&pmx_twsi1>;
+			pinctrl-names = "default";
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 00c2e5a9d863..3dcb5c26b78b 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -33,8 +33,6 @@
 
 		i2c at 11100 {
 			status = "okay";
-			pinctrl-0 = <&pmx_twsi1>;
-			pinctrl-names = "default";
 
 			s35390a: s35390a at 30 {
 				compatible = "s35390a";
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
index bc07aa5e6698..4e10e92b7822 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -45,8 +45,6 @@
 
 		i2c at 11100 {
 			status = "okay";
-			pinctrl-0 = <&pmx_twsi1>;
-			pinctrl-names = "default";
 
 			s24c02: s24c02 at 50 {
 				compatible = "24c02";
-- 
1.9.1
