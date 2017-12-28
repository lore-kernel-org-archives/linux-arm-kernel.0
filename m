From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Thu, 28 Dec 2017 17:33:36 +0100
Subject: [PATCH v2 2/2] arm: dts: sun8i: a83t: a711: Add touchscreen node
In-Reply-To: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
References: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
Message-ID: <20171228163336.28131-3-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tha A711 tablet has a FocalTech EDT-FT5x06 Polytouch touchscreen.
It is connected via I2C0. The reset line is PD5, the interrupt
line is PL7 and the VCC supply is the ldo_io0 regulator.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index a021ee6da396..7840f9aa9094 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -105,6 +105,22 @@
 	status = "okay";
 };
 
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen at 38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&pio 3 5 GPIO_ACTIVE_LOW>;
+		vcc-supply = <&reg_ldo_io0>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <600>;
+	};
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_dcdc1>;
 	pinctrl-names = "default";
-- 
2.11.0
