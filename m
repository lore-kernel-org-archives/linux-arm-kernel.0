From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 26 Apr 2015 08:15:51 -0000
Subject: [PATCH 1/3] ARM: dts: sunxi: A10s Olinuxino add missing SPI and
 simplefb.
In-Reply-To: <cover.1430034797.git.hramrach@gmail.com>
References: <cover.1430034797.git.hramrach@gmail.com>
Message-ID: <f6e34cb3f0b72fcb0ae18ccf96962fb8a1c477f7.1430034797.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 12 ++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                | 28 ++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index aa88ee8..e546b3f 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -59,6 +59,12 @@
 	model = "Olimex A10s-Olinuxino Micro";
 	compatible = "olimex,a10s-olinuxino-micro", "allwinner,sun5i-a10s";
 
+	chosen {
+		framebuffer at 0 {
+			status = "okay";
+		};
+	};
+
 	aliases {
 		serial0 = &uart0;
 		serial1 = &uart2;
@@ -182,6 +188,12 @@
 	status = "okay";
 };
 
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "okay";
+};
+
 &ohci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index a78c95d..438eba1 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -154,6 +154,20 @@
 			clocks = <&apb1_gates 18>;
 			status = "disabled";
 		};
+
+		spi2: spi at 01c17000 {
+			compatible = "allwinner,sun4i-a10-spi";
+			reg = <0x01c17000 0x1000>;
+			interrupts = <12>;
+			clocks = <&ahb_gates 22>, <&spi2_clk>;
+			clock-names = "ahb", "mod";
+			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
+			       <&dma SUN4I_DMA_DEDICATED 28>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 };
 
@@ -198,4 +212,18 @@
 		allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	spi2_pins_a: spi2 at 0 {
+		allwinner,pins = "PB11", "PB12", "PB13", "PB14";
+		allwinner,function = "spi2";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	spi2_pins_b: spi2 at 1 {
+		allwinner,pins = "PE00", "PE01", "PE02", "PE03";
+		allwinner,function = "spi2";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
-- 
2.1.4
