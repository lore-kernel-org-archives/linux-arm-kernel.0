From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 29 Mar 2013 19:14:38 +0100
Subject: [PATCH 3/4] ARM: orion5x: add gigabit ethernet device tree node
In-Reply-To: <1364580879-4297-1-git-send-email-florian@openwrt.org>
References: <1364580879-4297-1-git-send-email-florian@openwrt.org>
Message-ID: <1364580879-4297-4-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the gigabit ethernet device tree node to orion5x.dtsi.
This node is disabled by default and must be enabled on a per-board
basis. For completeness and easier testing the MDIO node is also added
and disabled by default.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/arm/boot/dts/orion5x.dtsi |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 8aad00f..8d83220 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -94,5 +94,28 @@
 			interrupts = <22>;
 			status = "okay";
 		};
+
+		mdio at 72004 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "marvell,orion-mdio";
+			reg = <0x72004 0x84>;
+			status = "disabled";
+		};
+
+		ethernet-group at 70000 {
+			#address-cells = <1>.
+			#size-cells = <0>;
+			compatible = "marvell,mv643xx-eth-block";
+			reg = <0x70000 0x4000>;
+			status = "disabled";
+
+			egiga0: ethernet at 0 {
+				device_type = "network";
+				compatible = "marvell,mv643xx-eth";
+				reg = <0>;
+				interrupts = <21>;
+			};
+		};
 	};
 };
-- 
1.7.10.4
