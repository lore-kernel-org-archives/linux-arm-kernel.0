From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 20 Dec 2017 23:11:55 +0000
Subject: [PATCH 3/4] ARM: dts: vf610-zii-dev-rev-b: add PHYs for switch2
In-Reply-To: <20171220231108.GJ10595@n2100.armlinux.org.uk>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
Message-ID: <E1eRnWl-0006VL-TL@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch 2 has an 88e1545 PHY behind it, which is a quad PHY.  Only the
first three PHYs are used, the remaining PHY is unused.  When we wire
up the SFF sockets in a later commit, the omission of this causes the
fourth PHY to be used for port 3.  Specifying the PHYs in DT avoids
the auto-probing of the bus, and discovery of this PHY.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index ede8649ba515..782b69a3acdf 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -255,16 +255,19 @@
 					port at 0 {
 						reg = <0>;
 						label = "lan6";
+						phy-handle = <&switch2phy0>;
 					};
 
 					port at 1 {
 						reg = <1>;
 						label = "lan7";
+						phy-handle = <&switch2phy1>;
 					};
 
 					port at 2 {
 						reg = <2>;
 						label = "lan8";
+						phy-handle = <&switch2phy2>;
 					};
 
 					port at 3 {
@@ -304,6 +307,20 @@
 						};
 					};
 				};
+				mdio {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					switch2phy0: phy at 0 {
+						reg = <0>;
+					};
+					switch2phy1: phy at 1 {
+						reg = <1>;
+					};
+					switch2phy2: phy at 2 {
+						reg = <2>;
+					};
+				};
 			};
 		};
 
-- 
2.7.4
