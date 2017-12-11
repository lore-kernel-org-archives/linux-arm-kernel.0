From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 11 Dec 2017 16:58:44 +0000
Subject: [PATCH 17/20] ARM: dts: imx6qdl-hummingboard2: add PWM3 support
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <E1eORPg-0000Ir-Mw@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 6954d4875cd8..1089f693ebde 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -361,6 +361,12 @@
 			>;
 		};
 
+		pinctrl_hummingboard2_pwm3: pwm3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_DAT1__PWM3_OUT 0x1b0b1
+			>;
+		};
+
 		pinctrl_hummingboard2_sgtl5000: hummingboard2-sgtl5000 {
 			fsl,pins = <
 				MX6QDL_PAD_DISP0_DAT19__AUD5_RXD 0x130b0
@@ -463,6 +469,12 @@
 	status = "okay";
 };
 
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard2_pwm3>;
+	status = "okay";
+};
+
 &ssi1 {
 	status = "okay";
 };
-- 
2.7.4
