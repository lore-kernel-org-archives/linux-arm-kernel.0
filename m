From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  9 Mar 2017 18:28:27 +0100
Subject: [PATCH v3 3/3] ARM64: dts: marvell: armada-37xx: Add USB2 node
In-Reply-To: <20170309172827.17874-1-gregory.clement@free-electrons.com>
References: <20170309172827.17874-1-gregory.clement@free-electrons.com>
Message-ID: <20170309172827.17874-4-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 37xx SoC embedded an EHCI controller. This patch adds the device
tree node enabling its support.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 6 ++++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 864936acc316..aa39339b6582 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -134,6 +134,12 @@
 	status = "okay";
 };
 
+/* CON27 */
+&usb2 {
+	status = "okay";
+};
+
+
 &mdio {
 	status = "okay";
 	phy0: ethernet-phy at 0 {
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index cf0c2f9ebd7d..7639518d8ee1 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -204,6 +204,13 @@
 				status = "disabled";
 			};
 
+			usb2: usb at 5e000 {
+				compatible = "marvell,armada-3700-ehci";
+				reg = <0x5e000 0x2000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			xor at 60900 {
 				compatible = "marvell,armada-3700-xor";
 				reg = <0x60900 0x100
-- 
2.11.0
