From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  5 Dec 2014 15:44:56 +0100
Subject: [PATCH 3/5] ARM: mvebu: a38x: Fix node names
In-Reply-To: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1417790698-9792-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1417790698-9792-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some nodes in the DTs have a reg property but no unit name in their node name.

This contradicts the way the ePAPR defines the node names. Fix this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-385-db.dts | 2 +-
 arch/arm/boot/dts/armada-385-rd.dts | 2 +-
 arch/arm/boot/dts/armada-385.dtsi   | 2 +-
 arch/arm/boot/dts/armada-38x.dtsi   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index 1af886f1e486..d2ad03e08c17 100644
--- a/arch/arm/boot/dts/armada-385-db.dts
+++ b/arch/arm/boot/dts/armada-385-db.dts
@@ -74,7 +74,7 @@
 				phy-mode = "rgmii-id";
 			};
 
-			mdio {
+			mdio at 72004 {
 				phy0: ethernet-phy at 0 {
 					reg = <0>;
 				};
diff --git a/arch/arm/boot/dts/armada-385-rd.dts b/arch/arm/boot/dts/armada-385-rd.dts
index aaca2861dc87..74a3bfe6efd7 100644
--- a/arch/arm/boot/dts/armada-385-rd.dts
+++ b/arch/arm/boot/dts/armada-385-rd.dts
@@ -67,7 +67,7 @@
 			};
 
 
-			mdio {
+			mdio at 72004 {
 				phy0: ethernet-phy at 0 {
 					reg = <0>;
 				};
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 6283d7912f71..5249a4d3c207 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -37,7 +37,7 @@
 
 	soc {
 		internal-regs {
-			pinctrl {
+			pinctrl at 18000 {
 				compatible = "marvell,mv88f6820-pinctrl";
 				reg = <0x18000 0x20>;
 			};
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 242d0ecc99f3..221cca4e79fc 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -193,7 +193,7 @@
 				status = "disabled";
 			};
 
-			pinctrl {
+			pinctrl at 18000 {
 				compatible = "marvell,mv88f6820-pinctrl";
 				reg = <0x18000 0x20>;
 			};
@@ -373,7 +373,7 @@
 				status = "disabled";
 			};
 
-			mdio {
+			mdio at 72004 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "marvell,orion-mdio";
-- 
2.2.0
