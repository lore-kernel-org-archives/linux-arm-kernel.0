From: b38611@freescale.com (Fugang Duan)
Date: Fri, 17 Jul 2015 16:38:24 +0800
Subject: [PATCH v1 4/4] ARM: dts: imx6ul-14x14-evk: add fec1 and fec2 support
In-Reply-To: <1437122304-20598-1-git-send-email-b38611@freescale.com>
References: <1437122304-20598-1-git-send-email-b38611@freescale.com>
Message-ID: <1437122304-20598-5-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ethernet fec1 and fec2 support for i.MX6ul 14x14 evk board.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 61b41ee..ef93291 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -44,6 +44,35 @@
 	soc-supply = <&reg_soc>;
 };
 
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy at 2 {
+			reg = <2>;
+		};
+
+		ethphy1: ethernet-phy at 1 {
+			reg = <1>;
+		};
+	};
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
1.9.1
