From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri,  8 Dec 2017 22:54:19 +0100
Subject: [PATCH 5/5] arm: dts: sun8i: a83t: a711: Add touchscreen node
In-Reply-To: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Message-ID: <20171208215419.30396-6-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tha A711 tablet has a FocalTech EDT-FT5x06 Polytouch touchscreen.
It is connected via I2C0 so add his node in i2c0's node.

The reset line is PD5, the interrupt line is PL7 and the power
supply is the ldo_io0 regulator.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 84cca1a48cea..738359917a34 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -110,6 +110,17 @@
 	pinctrl-0 = <&i2c0_pins>;
 	clock-frequency = <400000>;
 	status = "okay";
+
+	polytouch: edt-ft5x06 at 38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&pio 3 5 GPIO_ACTIVE_LOW>;
+		power-supply = <&reg_ldo_io0>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <600>;
+	};
 };
 
 &mmc0 {
-- 
2.11.0
