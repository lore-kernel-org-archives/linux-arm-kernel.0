From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Jan 2015 16:28:16 +0100
Subject: [PATCH v2 3/7] ARM: mvebu: a38x: Fix node names
In-Reply-To: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1420558100-4700-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some nodes in the DTs have a reg property but no unit name in their node name.

This contradicts the way the ePAPR defines the node names. Fix this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/armada-380.dtsi   | 2 +-
 arch/arm/boot/dts/armada-385-db.dts | 2 +-
 arch/arm/boot/dts/armada-385-rd.dts | 2 +-
 arch/arm/boot/dts/armada-385.dtsi   | 2 +-
 arch/arm/boot/dts/armada-38x.dtsi   | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index 4173a8ab34e7..13400ce88c54 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -32,7 +32,7 @@
 
 	soc {
 		internal-regs {
-			pinctrl {
+			pinctrl at 18000 {
 				compatible = "marvell,mv88f6810-pinctrl";
 				reg = <0x18000 0x20>;
 			};
diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
index 2aaa9d2ac284..212605ccc7b6 100644
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
index 74391dace9e7..ada1f206028b 100644
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
2.2.1
