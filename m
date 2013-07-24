From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 24 Jul 2013 17:20:03 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl-sabresd: Add touchscreen support
Message-ID: <1374697204-18474-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx6 sabresd boards have a egalax touchscreen controller connected via I2C3.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Fix the i2c bus and irq line as per the production sabresd board
- Tested via evtest

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 1d2dcef..bca6c2b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -131,6 +131,21 @@
        };
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_2>;
+	status = "okay";
+
+	egalax_ts at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <7 2>;
+		wakeup-gpios = <&gpio6 7 0>;
+	};
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -145,6 +160,7 @@
 				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
 				MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x80000000
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
+				MX6QDL_PAD_NANDF_CLE__GPIO6_IO07 0x80000000
 			>;
 		};
 	};
-- 
1.8.1.2
