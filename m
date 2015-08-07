From: b20788@freescale.com (Anson Huang)
Date: Fri, 7 Aug 2015 22:28:33 +0800
Subject: [PATCH] ARM: dts: imx6ul: add pm_power_off support
Message-ID: <1438957713-27661-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6UL can be powered off by programming SNVS.

When long press ON/OFF button(5 seconds),
PMIC_ON_REQ pin will be set to low and external
PMIC will be powered off.

And system can be powered on by long press ON/OFF
button again.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 4 ++++
 arch/arm/boot/dts/imx6ul.dtsi          | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index ee2243b..c27f3c4 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -58,6 +58,10 @@
 	};
 };
 
+&snvs_poweroff {
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 514ae43..446913e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -404,6 +404,14 @@
 					interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				};
 
+				snvs_poweroff: snvs-poweroff {
+					compatible = "syscon-poweroff";
+					regmap = <&snvs>;
+					offset = <0x38>;
+					mask = <0x60>;
+					status = "disabled";
+				};
+
 				snvs_pwrkey: snvs-powerkey {
 					compatible = "fsl,sec-v4.0-pwrkey";
 					regmap = <&snvs>;
-- 
1.9.1
