From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  3 Mar 2015 15:41:03 +0100
Subject: [PATCH v3 08/20] ARM: mvebu: fix unit address of MPIC nodes
In-Reply-To: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1425393675-17820-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1425393675-17820-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Device Tree nodes describing the MPIC nodes on Armada 370, 375,
38x and XP had a unit address that did not match the first reg
property, as suggested by the ePAPR. This commit fixes that.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 2 +-
 arch/arm/boot/dts/armada-370.dtsi    | 2 +-
 arch/arm/boot/dts/armada-375.dtsi    | 2 +-
 arch/arm/boot/dts/armada-38x.dtsi    | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 1058cf6..7b3393e 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -223,7 +223,7 @@
 				      <0x20250 0x8>;
 			};
 
-			mpic: interrupt-controller at 20000 {
+			mpic: interrupt-controller at 20a00 {
 				compatible = "marvell,mpic";
 				#interrupt-cells = <1>;
 				#size-cells = <1>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 27397f1..50f259b 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -232,7 +232,7 @@
 				reg = <0x18330 0x4>;
 			};
 
-			interrupt-controller at 20000 {
+			interrupt-controller at 20a00 {
 				reg = <0x20a00 0x1d0>, <0x21870 0x58>;
 			};
 
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 6420693..c6fedf2 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -394,7 +394,7 @@
 				reg = <0x20000 0x100>, <0x20180 0x20>;
 			};
 
-			mpic: interrupt-controller at 20000 {
+			mpic: interrupt-controller at 20a00 {
 				compatible = "marvell,mpic";
 				reg = <0x20a00 0x2d0>, <0x21070 0x58>;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 7cf6657..6aaba7c6 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -367,7 +367,7 @@
 				reg = <0x20000 0x100>, <0x20180 0x20>;
 			};
 
-			mpic: interrupt-controller at 20000 {
+			mpic: interrupt-controller at 20a00 {
 				compatible = "marvell,mpic";
 				reg = <0x20a00 0x2d0>, <0x21070 0x58>;
 				#interrupt-cells = <1>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index bbabee5..ff47345 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -154,7 +154,7 @@
 				clocks = <&coreclk 1>;
 			};
 
-			interrupt-controller at 20000 {
+			interrupt-controller at 20a00 {
 			      reg = <0x20a00 0x2d0>, <0x21070 0x58>;
 			};
 
-- 
2.1.0
