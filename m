From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Jul 2013 18:41:16 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabresd: Add touchscreen support
Message-ID: <1374615677-18437-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

mx6 sabresd boards have a egalax touchscreen controller connected via i2c2.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Hi Shawn,

I don't have access to a sabresd board at the moment, so could not test this.

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 166b9ae..5124994 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -129,6 +129,21 @@
        };
 };
 
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_2>;
+	status = "okay";
+
+	egalax_ts at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <8 2>;
+		wakeup-gpios = <&gpio6 8 0>;
+	};
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -143,6 +158,7 @@
 				MX6QDL_PAD_NANDF_D2__GPIO2_IO02 0x80000000
 				MX6QDL_PAD_NANDF_D3__GPIO2_IO03 0x80000000
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x130b0
+				MX6QDL_PAD_NANDF_ALE__GPIO6_IO08 0x80000000
 			>;
 		};
 	};
-- 
1.8.1.2
