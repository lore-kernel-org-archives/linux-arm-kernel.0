From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  8 Mar 2016 09:04:02 +0100
Subject: [PATCHv2 6/8] ARM: dts: imx6qdl-tx6: add mdio node for ethernet phy
In-Reply-To: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
References: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1457424244-14549-7-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mdio node and an appropriate PHY configuration to enable use of
the PHY interrupt for link status changes.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index dc813c2..a0d59ab 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -249,8 +249,22 @@
 	clock-names = "ipg", "ahb", "ptp", "enet_out";
 	phy-mode = "rmii";
 	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
+	phy-handle = <&etnphy>;
 	phy-supply = <&reg_3v3_etn>;
 	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		etnphy: ethernet-phy at 0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_enet_mdio>;
+			interrupts-extended = <&gpio7 1 IRQ_TYPE_EDGE_FALLING>;
+		};
+	};
 };
 
 &gpmi {
-- 
2.1.4
