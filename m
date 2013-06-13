From: b42378@freescale.com (Nicolin Chen)
Date: Thu, 13 Jun 2013 19:51:01 +0800
Subject: [PATCH 6/9] ARM: dtsi: imx6qdl-sabresd: Add WM8962 CODEC support
In-Reply-To: <cover.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
Message-ID: <d77dd407188926f61c787eb307dd142cf0b37e1b.1371123426.git.b42378@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add WM8962 CODEC support and enable its parent I2C bus.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 13af158..4ee2413 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -92,3 +92,32 @@
 	wp-gpios = <&gpio2 1 0>;
 	status = "okay";
 };
+
+&i2c1 {
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_2>;
+
+	codec: wm8962 at 1a {
+		compatible = "wlf,wm8962";
+		reg = <0x1a>;
+		clocks = <&clks 169>;
+		DCVDD-supply = <&reg_audio>;	/* 1.8v */
+		DBVDD-supply = <&reg_audio>;	/* 1.8v */
+		AVDD-supply = <&reg_audio>;	/* 1.8v */
+		CPVDD-supply = <&reg_audio>;	/* 1.8v */
+		MICVDD-supply = <&reg_audio>;	/* 3.3v */
+		PLLVDD-supply = <&reg_audio>;	/* 1.8v */
+		SPKVDD1-supply = <&reg_audio>;	/* 4.2v */
+		SPKVDD2-supply = <&reg_audio>;	/* 4.2v */
+		gpio-cfg = <
+			0x0000 /* 0:Default */
+			0x0000 /* 1:Default */
+			0x0013 /* 2:FN_DMICCLK */
+			0x0000 /* 3:Default */
+			0x8014 /* 4:FN_DMICCDAT */
+			0x0000 /* 5:Default */
+		>;
+       };
+};
-- 
1.7.1
