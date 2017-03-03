From: jun.gao@mediatek.com (Jun Gao)
Date: Fri, 3 Mar 2017 10:05:13 +0800
Subject: [PATCH v3 2/2] arm: dts: Add Mediatek MT2701 i2c device node
In-Reply-To: <1488506713-20767-1-git-send-email-jun.gao@mediatek.com>
References: <1488506713-20767-1-git-send-email-jun.gao@mediatek.com>
Message-ID: <1488506713-20767-3-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Gao <jun.gao@mediatek.com>

Add MT2701 i2c device node.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 arch/arm/boot/dts/mt2701-evb.dts |   44 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi    |   42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index 082ca88..a908e94 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -24,6 +24,50 @@
 	};
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
+
+&pio {
+	i2c0_pins_a: i2c0 at 0 {
+		pins1 {
+			pinmux = <MT2701_PIN_75_SDA0__FUNC_SDA0>,
+				 <MT2701_PIN_76_SCL0__FUNC_SCL0>;
+			bias-disable;
+		};
+	};
+
+	i2c1_pins_a: i2c1 at 0 {
+		pins1 {
+			pinmux = <MT2701_PIN_57_SDA1__FUNC_SDA1>,
+				 <MT2701_PIN_58_SCL1__FUNC_SCL1>;
+			bias-disable;
+		};
+	};
+
+	i2c2_pins_a: i2c2 at 0 {
+		pins1 {
+			pinmux = <MT2701_PIN_77_SDA2__FUNC_SDA2>,
+				 <MT2701_PIN_78_SCL2__FUNC_SCL2>;
+			bias-disable;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index bdf8954..0d1539f 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -227,6 +227,48 @@
 		status = "disabled";
 	};
 
+	i2c0: i2c at 11007000 {
+		compatible = "mediatek,mt2701-i2c",
+			     "mediatek,mt6577-i2c";
+		reg = <0 0x11007000 0 0x70>,
+		      <0 0x11000200 0 0x80>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <16>;
+		clocks = <&pericfg CLK_PERI_I2C0>, <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "main", "dma";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at 11008000 {
+		compatible = "mediatek,mt2701-i2c",
+			     "mediatek,mt6577-i2c";
+		reg = <0 0x11008000 0 0x70>,
+		      <0 0x11000280 0 0x80>;
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <16>;
+		clocks = <&pericfg CLK_PERI_I2C1>, <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "main", "dma";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at 11009000 {
+		compatible = "mediatek,mt2701-i2c",
+			     "mediatek,mt6577-i2c";
+		reg = <0 0x11009000 0 0x70>,
+		      <0 0x11000300 0 0x80>;
+		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_LOW>;
+		clock-div = <16>;
+		clocks = <&pericfg CLK_PERI_I2C2>, <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "main", "dma";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	mmsys: syscon at 14000000 {
 		compatible = "mediatek,mt2701-mmsys", "syscon";
 		reg = <0 0x14000000 0 0x1000>;
-- 
1.7.9.5
