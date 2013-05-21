From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 May 2013 12:33:27 +0200
Subject: [PATCH 2/9] arm: mvebu: fix length of Ethernet registers area in .dtsi
In-Reply-To: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369132414-18959-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The length of the registers area for the Marvell 370/XP Ethernet
controller was incorrect in the .dtsi: 0x2400 while it should have
been 0x4000. Until now, this problem wasn't noticed because there was
a large static mapping for all I/Os set up by ->map_io(). But since
we're going to get rid of this static mapping, we need to ensure that
the register areas are properly sized.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi     |    4 ++--
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |    2 +-
 arch/arm/boot/dts/armada-xp.dtsi         |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 75de3fe..96a6bcd 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -95,7 +95,7 @@
 
 			ethernet at 70000 {
 				compatible = "marvell,armada-370-neta";
-				reg = <0x70000 0x2500>;
+				reg = <0x70000 0x4000>;
 				interrupts = <8>;
 				clocks = <&gateclk 4>;
 				status = "disabled";
@@ -103,7 +103,7 @@
 
 			ethernet at 74000 {
 				compatible = "marvell,armada-370-neta";
-				reg = <0x74000 0x2500>;
+				reg = <0x74000 0x4000>;
 				interrupts = <10>;
 				clocks = <&gateclk 3>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 6ab56bd..488ca5e 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -107,7 +107,7 @@
 
 			ethernet at 34000 {
 				compatible = "marvell,armada-370-neta";
-				reg = <0x34000 0x2500>;
+				reg = <0x34000 0x4000>;
 				interrupts = <14>;
 				clocks = <&gateclk 1>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index bacab11..67936f89 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -88,7 +88,7 @@
 
 			ethernet at 30000 {
 				compatible = "marvell,armada-370-neta";
-				reg = <0x30000 0x2500>;
+				reg = <0x30000 0x4000>;
 				interrupts = <12>;
 				clocks = <&gateclk 2>;
 				status = "disabled";
-- 
1.7.9.5
