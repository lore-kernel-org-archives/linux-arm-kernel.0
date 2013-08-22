From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 22 Aug 2013 16:19:29 +0200
Subject: [PATCH v6 4/4] ARM: dts: mvebu: Update with the new compatible string
 for mv64xxx-i2c
In-Reply-To: <1377181169-17483-1-git-send-email-gregory.clement@free-electrons.com>
References: <1377181169-17483-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1377181169-17483-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mv64xxx-i2c embedded in the Armada XP have a new feature to
offload i2c transaction. This new version of the IP come also with
some errata. This lead to the introduction to a another compatible
string.

This commit split the i2c information into armada-370.dtsi and
armada-xp.dtsi. Most of the data remains the same and stay in the
common file Armada-370-xp.dtsi. With this new feature the size of the
registers are bigger for Armada XP and the new compatible string is
used.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |  2 --
 arch/arm/boot/dts/armada-370.dtsi    |  8 ++++++++
 arch/arm/boot/dts/armada-xp.dtsi     | 10 ++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 90b1176..d8b24c9 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -121,7 +121,6 @@
 
 			i2c0: i2c at 11000 {
 				compatible = "marvell,mv64xxx-i2c";
-				reg = <0x11000 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <31>;
@@ -132,7 +131,6 @@
 
 			i2c1: i2c at 11100 {
 				compatible = "marvell,mv64xxx-i2c";
-				reg = <0x11100 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <32>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index fa3dfc6..0e2eefa 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -155,6 +155,14 @@
 				};
 			};
 
+			i2c0: i2c at 11000 {
+				reg = <0x11000 0x20>;
+			};
+
+			i2c1: i2c at 11100 {
+				reg = <0x11100 0x20>;
+			};
+
 			usb at 50000 {
 				clocks = <&coreclk 0>;
 			};
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 416eb94..e1f2547 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -138,6 +138,16 @@
 				};
 			};
 
+			i2c0: i2c at 11000 {
+				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
+				reg = <0x11000 0x100>;
+			};
+
+			i2c1: i2c at 11100 {
+				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
+				reg = <0x11100 0x100>;
+			};
+
 			usb at 50000 {
 				clocks = <&gateclk 18>;
 			};
-- 
1.8.1.2
