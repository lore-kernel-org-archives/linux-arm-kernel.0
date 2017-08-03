From: huangtao@rock-chips.com (Tao Huang)
Date: Thu,  3 Aug 2017 11:21:36 +0800
Subject: [PATCH] ARM: dts: rockchip: convert rk3288 device tree files to 64
 bits
Message-ID: <1501730496-1893-1-git-send-email-huangtao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to use more than 4GB of RAM when the LPAE is
activated, the dts must be converted in 64 bits.

Signed-off-by: Tao Huang <huangtao@rock-chips.com>
---

Another way to support 64-bit memory is create a soc subnode, and move all
peripherals to this subnode. But it will break userspace compatibility.
For example,
/sys/devices/platform/ff0f0000.dwmmc
will be
/sys/devices/platform/soc/ff0f0000.dwmmc
Some system will stop work. So I selected this way.

Most of the changes by the following commands:
sed -e 's/0xff/0x0 0xff/g' -e 's/0x0 0xff[[:xdigit:]]\{6\}/& 0x0/g'
sed 's/reg = <0x0 0x80000000>/reg = <0x0 0x0 0x0 0x80000000>/'
sed 's/reg = <0 0x80000000>/reg = <0x0 0x0 0x0 0x80000000>/'
sed 's/reg = <0 0x8000000>/reg = <0x0 0x0 0x0 0x8000000>/'

 arch/arm/boot/dts/rk3288-evb.dtsi                 |   2 +-
 arch/arm/boot/dts/rk3288-fennec.dts               |   2 +-
 arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi |   2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi             |   2 +-
 arch/arm/boot/dts/rk3288-miqi.dts                 |   2 +-
 arch/arm/boot/dts/rk3288-phycore-som.dtsi         |   2 +-
 arch/arm/boot/dts/rk3288-popmetal.dts             |   2 +-
 arch/arm/boot/dts/rk3288-r89.dts                  |   2 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi           |   2 +-
 arch/arm/boot/dts/rk3288-tinker.dts               |   2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi              |   2 +-
 arch/arm/boot/dts/rk3288.dtsi                     | 178 +++++++++++-----------
 12 files changed, 100 insertions(+), 100 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 0dec94c3583b..3b2255812ab5 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -45,7 +45,7 @@
 / {
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
 	backlight: backlight {
diff --git a/arch/arm/boot/dts/rk3288-fennec.dts b/arch/arm/boot/dts/rk3288-fennec.dts
index 61d1c1028317..306ac78e1e1b 100644
--- a/arch/arm/boot/dts/rk3288-fennec.dts
+++ b/arch/arm/boot/dts/rk3288-fennec.dts
@@ -47,7 +47,7 @@
 	compatible = "rockchip,rk3288-fennec", "rockchip,rk3288";
 
 	memory at 0 {
-		reg = <0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
index 813496618d08..63f3b92d78db 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
@@ -47,7 +47,7 @@
 / {
 	memory at 0 {
 		device_type = "memory";
-		reg = <0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
 	ext_gmac: external-gmac-clock {
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 32dabae12e67..e3520220406a 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -46,7 +46,7 @@
 / {
 	memory at 0 {
 		device_type = "memory";
-		reg = <0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
 	adc-keys {
diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
index 30e93f694ae8..413ab859e3ea 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -54,7 +54,7 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
 	ext_gmac: external-gmac-clock {
diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
index 26cd3ad45160..0c7a54c59652 100644
--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -55,7 +55,7 @@
 	 */
 	memory {
 		device_type = "memory";
-		reg = <0 0x8000000>;
+		reg = <0x0 0x0 0x0 0x8000000>;
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index aa1f9ecff231..eaaadbc43e7a 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -50,7 +50,7 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
 	ext_gmac: external-gmac-clock {
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index 1145b62edde7..c1a535321efc 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -50,7 +50,7 @@
 
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
 	ext_gmac: external-gmac-clock {
diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index 749a9b86e6e2..db951024ad9a 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -43,7 +43,7 @@
 
 / {
 	memory at 0 {
-		reg = <0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-tinker.dts b/arch/arm/boot/dts/rk3288-tinker.dts
index f601c78386a9..78ab06235827 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dts
+++ b/arch/arm/boot/dts/rk3288-tinker.dts
@@ -50,7 +50,7 @@
 	compatible = "asus,rk3288-tinker", "rockchip,rk3288";
 
 	memory {
-		reg = <0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
 	};
 
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index d709fa1847f9..3a184ca004ab 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -49,7 +49,7 @@
 / {
 	memory at 0 {
 		device_type = "memory";
-		reg = <0x0 0x80000000>;
+		reg = <0x0 0x0 0x0 0x80000000>;
 	};
 
 	gpio_keys: gpio-keys {
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 2484f11761ea..b1995c0efb13 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -49,8 +49,8 @@
 #include <dt-bindings/soc/rockchip,boot-mode.h>
 
 / {
-	#address-cells = <1>;
-	#size-cells = <1>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
 	compatible = "rockchip,rk3288";
 
@@ -139,13 +139,13 @@
 
 	amba {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		ranges;
 
 		dmac_peri: dma-controller at ff250000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0xff250000 0x4000>;
+			reg = <0x0 0xff250000 0x0 0x4000>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
@@ -156,7 +156,7 @@
 
 		dmac_bus_ns: dma-controller at ff600000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0xff600000 0x4000>;
+			reg = <0x0 0xff600000 0x0 0x4000>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
@@ -168,7 +168,7 @@
 
 		dmac_bus_s: dma-controller at ffb20000 {
 			compatible = "arm,pl330", "arm,primecell";
-			reg = <0xffb20000 0x4000>;
+			reg = <0x0 0xffb20000 0x0 0x4000>;
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
@@ -179,8 +179,8 @@
 	};
 
 	reserved-memory {
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		ranges;
 
 		/*
@@ -194,7 +194,7 @@
 		 * is found.
 		 */
 		dma-unusable at fe000000 {
-			reg = <0xfe000000 0x1000000>;
+			reg = <0x0 0xfe000000 0x0 0x1000000>;
 		};
 	};
 
@@ -217,7 +217,7 @@
 
 	timer: timer at ff810000 {
 		compatible = "rockchip,rk3288-timer";
-		reg = <0xff810000 0x20>;
+		reg = <0x0 0xff810000 0x0 0x20>;
 		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&xin24m>, <&cru PCLK_TIMER>;
 		clock-names = "timer", "pclk";
@@ -236,7 +236,7 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0xff0c0000 0x4000>;
+		reg = <0x0 0xff0c0000 0x0 0x4000>;
 		resets = <&cru SRST_MMC0>;
 		reset-names = "reset";
 		status = "disabled";
@@ -250,7 +250,7 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0xff0d0000 0x4000>;
+		reg = <0x0 0xff0d0000 0x0 0x4000>;
 		resets = <&cru SRST_SDIO0>;
 		reset-names = "reset";
 		status = "disabled";
@@ -264,7 +264,7 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0xff0e0000 0x4000>;
+		reg = <0x0 0xff0e0000 0x0 0x4000>;
 		resets = <&cru SRST_SDIO1>;
 		reset-names = "reset";
 		status = "disabled";
@@ -278,7 +278,7 @@
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-		reg = <0xff0f0000 0x4000>;
+		reg = <0x0 0xff0f0000 0x0 0x4000>;
 		resets = <&cru SRST_EMMC>;
 		reset-names = "reset";
 		status = "disabled";
@@ -286,7 +286,7 @@
 
 	saradc: saradc at ff100000 {
 		compatible = "rockchip,saradc";
-		reg = <0xff100000 0x100>;
+		reg = <0x0 0xff100000 0x0 0x100>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		#io-channel-cells = <1>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
@@ -305,7 +305,7 @@
 		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
-		reg = <0xff110000 0x1000>;
+		reg = <0x0 0xff110000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -320,7 +320,7 @@
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
-		reg = <0xff120000 0x1000>;
+		reg = <0x0 0xff120000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -335,7 +335,7 @@
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_clk &spi2_tx &spi2_rx &spi2_cs0>;
-		reg = <0xff130000 0x1000>;
+		reg = <0x0 0xff130000 0x0 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
@@ -343,7 +343,7 @@
 
 	i2c1: i2c at ff140000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff140000 0x1000>;
+		reg = <0x0 0xff140000 0x0 0x1000>;
 		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -356,7 +356,7 @@
 
 	i2c3: i2c at ff150000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff150000 0x1000>;
+		reg = <0x0 0xff150000 0x0 0x1000>;
 		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -369,7 +369,7 @@
 
 	i2c4: i2c at ff160000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff160000 0x1000>;
+		reg = <0x0 0xff160000 0x0 0x1000>;
 		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -382,7 +382,7 @@
 
 	i2c5: i2c at ff170000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff170000 0x1000>;
+		reg = <0x0 0xff170000 0x0 0x1000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -395,7 +395,7 @@
 
 	uart0: serial at ff180000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff180000 0x100>;
+		reg = <0x0 0xff180000 0x0 0x100>;
 		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -408,7 +408,7 @@
 
 	uart1: serial at ff190000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff190000 0x100>;
+		reg = <0x0 0xff190000 0x0 0x100>;
 		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -421,7 +421,7 @@
 
 	uart2: serial at ff690000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff690000 0x100>;
+		reg = <0x0 0xff690000 0x0 0x100>;
 		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -434,7 +434,7 @@
 
 	uart3: serial at ff1b0000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff1b0000 0x100>;
+		reg = <0x0 0xff1b0000 0x0 0x100>;
 		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -447,7 +447,7 @@
 
 	uart4: serial at ff1c0000 {
 		compatible = "rockchip,rk3288-uart", "snps,dw-apb-uart";
-		reg = <0xff1c0000 0x100>;
+		reg = <0x0 0xff1c0000 0x0 0x100>;
 		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
@@ -535,7 +535,7 @@
 
 	tsadc: tsadc at ff280000 {
 		compatible = "rockchip,rk3288-tsadc";
-		reg = <0xff280000 0x100>;
+		reg = <0x0 0xff280000 0x0 0x100>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
 		clock-names = "tsadc", "apb_pclk";
@@ -552,7 +552,7 @@
 
 	gmac: ethernet at ff290000 {
 		compatible = "rockchip,rk3288-gmac";
-		reg = <0xff290000 0x10000>;
+		reg = <0x0 0xff290000 0x0 0x10000>;
 		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "macirq", "eth_wake_irq";
@@ -572,7 +572,7 @@
 
 	usb_host0_ehci: usb at ff500000 {
 		compatible = "generic-ehci";
-		reg = <0xff500000 0x100>;
+		reg = <0x0 0xff500000 0x0 0x100>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST0>;
 		clock-names = "usbhost";
@@ -586,7 +586,7 @@
 	usb_host1: usb at ff540000 {
 		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
 				"snps,dwc2";
-		reg = <0xff540000 0x40000>;
+		reg = <0x0 0xff540000 0x0 0x40000>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_USBHOST1>;
 		clock-names = "otg";
@@ -599,7 +599,7 @@
 	usb_otg: usb at ff580000 {
 		compatible = "rockchip,rk3288-usb", "rockchip,rk3066-usb",
 				"snps,dwc2";
-		reg = <0xff580000 0x40000>;
+		reg = <0x0 0xff580000 0x0 0x40000>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_OTG0>;
 		clock-names = "otg";
@@ -614,7 +614,7 @@
 
 	usb_hsic: usb at ff5c0000 {
 		compatible = "generic-ehci";
-		reg = <0xff5c0000 0x100>;
+		reg = <0x0 0xff5c0000 0x0 0x100>;
 		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_HSIC>;
 		clock-names = "usbhost";
@@ -623,7 +623,7 @@
 
 	i2c0: i2c at ff650000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff650000 0x1000>;
+		reg = <0x0 0xff650000 0x0 0x1000>;
 		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -636,7 +636,7 @@
 
 	i2c2: i2c at ff660000 {
 		compatible = "rockchip,rk3288-i2c";
-		reg = <0xff660000 0x1000>;
+		reg = <0x0 0xff660000 0x0 0x1000>;
 		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -649,7 +649,7 @@
 
 	pwm0: pwm at ff680000 {
 		compatible = "rockchip,rk3288-pwm";
-		reg = <0xff680000 0x10>;
+		reg = <0x0 0xff680000 0x0 0x10>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm0_pin>;
@@ -660,7 +660,7 @@
 
 	pwm1: pwm at ff680010 {
 		compatible = "rockchip,rk3288-pwm";
-		reg = <0xff680010 0x10>;
+		reg = <0x0 0xff680010 0x0 0x10>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm1_pin>;
@@ -671,7 +671,7 @@
 
 	pwm2: pwm at ff680020 {
 		compatible = "rockchip,rk3288-pwm";
-		reg = <0xff680020 0x10>;
+		reg = <0x0 0xff680020 0x0 0x10>;
 		#pwm-cells = <3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm2_pin>;
@@ -682,7 +682,7 @@
 
 	pwm3: pwm at ff680030 {
 		compatible = "rockchip,rk3288-pwm";
-		reg = <0xff680030 0x10>;
+		reg = <0x0 0xff680030 0x0 0x10>;
 		#pwm-cells = <2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm3_pin>;
@@ -693,10 +693,10 @@
 
 	bus_intmem at ff700000 {
 		compatible = "mmio-sram";
-		reg = <0xff700000 0x18000>;
+		reg = <0x0 0xff700000 0x0 0x18000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0 0xff700000 0x18000>;
+		ranges = <0 0x0 0xff700000 0x18000>;
 		smp-sram at 0 {
 			compatible = "rockchip,rk3066-smp-sram";
 			reg = <0x00 0x10>;
@@ -705,12 +705,12 @@
 
 	sram at ff720000 {
 		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
-		reg = <0xff720000 0x1000>;
+		reg = <0x0 0xff720000 0x0 0x1000>;
 	};
 
 	pmu: power-management at ff730000 {
 		compatible = "rockchip,rk3288-pmu", "syscon", "simple-mfd";
-		reg = <0xff730000 0x100>;
+		reg = <0x0 0xff730000 0x0 0x100>;
 
 		power: power-controller {
 			compatible = "rockchip,rk3288-power-controller";
@@ -831,12 +831,12 @@
 
 	sgrf: syscon at ff740000 {
 		compatible = "rockchip,rk3288-sgrf", "syscon";
-		reg = <0xff740000 0x1000>;
+		reg = <0x0 0xff740000 0x0 0x1000>;
 	};
 
 	cru: clock-controller at ff760000 {
 		compatible = "rockchip,rk3288-cru";
-		reg = <0xff760000 0x1000>;
+		reg = <0x0 0xff760000 0x0 0x1000>;
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -854,7 +854,7 @@
 
 	grf: syscon at ff770000 {
 		compatible = "rockchip,rk3288-grf", "syscon", "simple-mfd";
-		reg = <0xff770000 0x1000>;
+		reg = <0x0 0xff770000 0x0 0x1000>;
 
 		edp_phy: edp-phy {
 			compatible = "rockchip,rk3288-dp-phy";
@@ -903,7 +903,7 @@
 
 	wdt: watchdog at ff800000 {
 		compatible = "rockchip,rk3288-wdt", "snps,dw-wdt";
-		reg = <0xff800000 0x100>;
+		reg = <0x0 0xff800000 0x0 0x100>;
 		clocks = <&cru PCLK_WDT>;
 		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
@@ -911,7 +911,7 @@
 
 	spdif: sound at ff88b0000 {
 		compatible = "rockchip,rk3288-spdif", "rockchip,rk3066-spdif";
-		reg = <0xff8b0000 0x10000>;
+		reg = <0x0 0xff8b0000 0x0 0x10000>;
 		#sound-dai-cells = <0>;
 		clock-names = "hclk", "mclk";
 		clocks = <&cru HCLK_SPDIF8CH>, <&cru SCLK_SPDIF8CH>;
@@ -926,7 +926,7 @@
 
 	i2s: i2s at ff890000 {
 		compatible = "rockchip,rk3288-i2s", "rockchip,rk3066-i2s";
-		reg = <0xff890000 0x10000>;
+		reg = <0x0 0xff890000 0x0 0x10000>;
 		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -943,7 +943,7 @@
 
 	crypto: cypto-controller at ff8a0000 {
 		compatible = "rockchip,rk3288-crypto";
-		reg = <0xff8a0000 0x4000>;
+		reg = <0x0 0xff8a0000 0x0 0x4000>;
 		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
 			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
@@ -955,7 +955,7 @@
 
 	vopb: vop at ff930000 {
 		compatible = "rockchip,rk3288-vop";
-		reg = <0xff930000 0x19c>;
+		reg = <0x0 0xff930000 0x0 0x19c>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
@@ -988,7 +988,7 @@
 
 	vopb_mmu: iommu at ff930300 {
 		compatible = "rockchip,iommu";
-		reg = <0xff930300 0x100>;
+		reg = <0x0 0xff930300 0x0 0x100>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopb_mmu";
 		power-domains = <&power RK3288_PD_VIO>;
@@ -998,7 +998,7 @@
 
 	vopl: vop at ff940000 {
 		compatible = "rockchip,rk3288-vop";
-		reg = <0xff940000 0x19c>;
+		reg = <0x0 0xff940000 0x0 0x19c>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
 		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
@@ -1031,7 +1031,7 @@
 
 	vopl_mmu: iommu at ff940300 {
 		compatible = "rockchip,iommu";
-		reg = <0xff940300 0x100>;
+		reg = <0x0 0xff940300 0x0 0x100>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopl_mmu";
 		power-domains = <&power RK3288_PD_VIO>;
@@ -1041,7 +1041,7 @@
 
 	mipi_dsi: mipi at ff960000 {
 		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
-		reg = <0xff960000 0x4000>;
+		reg = <0x0 0xff960000 0x0 0x4000>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_MIPI_DSI0>;
 		clock-names = "ref", "pclk";
@@ -1069,7 +1069,7 @@
 
 	edp: dp at ff970000 {
 		compatible = "rockchip,rk3288-dp";
-		reg = <0xff970000 0x4000>;
+		reg = <0x0 0xff970000 0x0 0x4000>;
 		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
 		clock-names = "dp", "pclk";
@@ -1101,7 +1101,7 @@
 
 	hdmi: hdmi at ff980000 {
 		compatible = "rockchip,rk3288-dw-hdmi";
-		reg = <0xff980000 0x20000>;
+		reg = <0x0 0xff980000 0x0 0x20000>;
 		reg-io-width = <4>;
 		rockchip,grf = <&grf>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
@@ -1128,7 +1128,7 @@
 
 	gpu: mali at ffa30000 {
 		compatible = "rockchip,rk3288-mali", "arm,mali-t760", "arm,mali-midgard";
-		reg = <0xffa30000 0x10000>;
+		reg = <0x0 0xffa30000 0x0 0x10000>;
 		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -1170,72 +1170,72 @@
 
 	qos_gpu_r: qos at ffaa0000 {
 		compatible = "syscon";
-		reg = <0xffaa0000 0x20>;
+		reg = <0x0 0xffaa0000 0x0 0x20>;
 	};
 
 	qos_gpu_w: qos at ffaa0080 {
 		compatible = "syscon";
-		reg = <0xffaa0080 0x20>;
+		reg = <0x0 0xffaa0080 0x0 0x20>;
 	};
 
 	qos_vio1_vop: qos at ffad0000 {
 		compatible = "syscon";
-		reg = <0xffad0000 0x20>;
+		reg = <0x0 0xffad0000 0x0 0x20>;
 	};
 
 	qos_vio1_isp_w0: qos at ffad0100 {
 		compatible = "syscon";
-		reg = <0xffad0100 0x20>;
+		reg = <0x0 0xffad0100 0x0 0x20>;
 	};
 
 	qos_vio1_isp_w1: qos at ffad0180 {
 		compatible = "syscon";
-		reg = <0xffad0180 0x20>;
+		reg = <0x0 0xffad0180 0x0 0x20>;
 	};
 
 	qos_vio0_vop: qos at ffad0400 {
 		compatible = "syscon";
-		reg = <0xffad0400 0x20>;
+		reg = <0x0 0xffad0400 0x0 0x20>;
 	};
 
 	qos_vio0_vip: qos at ffad0480 {
 		compatible = "syscon";
-		reg = <0xffad0480 0x20>;
+		reg = <0x0 0xffad0480 0x0 0x20>;
 	};
 
 	qos_vio0_iep: qos at ffad0500 {
 		compatible = "syscon";
-		reg = <0xffad0500 0x20>;
+		reg = <0x0 0xffad0500 0x0 0x20>;
 	};
 
 	qos_vio2_rga_r: qos at ffad0800 {
 		compatible = "syscon";
-		reg = <0xffad0800 0x20>;
+		reg = <0x0 0xffad0800 0x0 0x20>;
 	};
 
 	qos_vio2_rga_w: qos at ffad0880 {
 		compatible = "syscon";
-		reg = <0xffad0880 0x20>;
+		reg = <0x0 0xffad0880 0x0 0x20>;
 	};
 
 	qos_vio1_isp_r: qos at ffad0900 {
 		compatible = "syscon";
-		reg = <0xffad0900 0x20>;
+		reg = <0x0 0xffad0900 0x0 0x20>;
 	};
 
 	qos_video: qos at ffae0000 {
 		compatible = "syscon";
-		reg = <0xffae0000 0x20>;
+		reg = <0x0 0xffae0000 0x0 0x20>;
 	};
 
 	qos_hevc_r: qos at ffaf0000 {
 		compatible = "syscon";
-		reg = <0xffaf0000 0x20>;
+		reg = <0x0 0xffaf0000 0x0 0x20>;
 	};
 
 	qos_hevc_w: qos at ffaf0080 {
 		compatible = "syscon";
-		reg = <0xffaf0080 0x20>;
+		reg = <0x0 0xffaf0080 0x0 0x20>;
 	};
 
 	gic: interrupt-controller at ffc01000 {
@@ -1244,16 +1244,16 @@
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 
-		reg = <0xffc01000 0x1000>,
-		      <0xffc02000 0x2000>,
-		      <0xffc04000 0x2000>,
-		      <0xffc06000 0x2000>;
+		reg = <0x0 0xffc01000 0x0 0x1000>,
+		      <0x0 0xffc02000 0x0 0x2000>,
+		      <0x0 0xffc04000 0x0 0x2000>,
+		      <0x0 0xffc06000 0x0 0x2000>;
 		interrupts = <GIC_PPI 9 0xf04>;
 	};
 
 	efuse: efuse at ffb40000 {
 		compatible = "rockchip,rk3288-efuse";
-		reg = <0xffb40000 0x20>;
+		reg = <0x0 0xffb40000 0x0 0x20>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		clocks = <&cru PCLK_EFUSE256>;
@@ -1268,13 +1268,13 @@
 		compatible = "rockchip,rk3288-pinctrl";
 		rockchip,grf = <&grf>;
 		rockchip,pmu = <&pmu>;
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		ranges;
 
 		gpio0: gpio0 at ff750000 {
 			compatible = "rockchip,gpio-bank";
-			reg =	<0xff750000 0x100>;
+			reg = <0x0 0xff750000 0x0 0x100>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO0>;
 
@@ -1287,7 +1287,7 @@
 
 		gpio1: gpio1 at ff780000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff780000 0x100>;
+			reg = <0x0 0xff780000 0x0 0x100>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>;
 
@@ -1300,7 +1300,7 @@
 
 		gpio2: gpio2 at ff790000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff790000 0x100>;
+			reg = <0x0 0xff790000 0x0 0x100>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>;
 
@@ -1313,7 +1313,7 @@
 
 		gpio3: gpio3 at ff7a0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7a0000 0x100>;
+			reg = <0x0 0xff7a0000 0x0 0x100>;
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>;
 
@@ -1326,7 +1326,7 @@
 
 		gpio4: gpio4 at ff7b0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7b0000 0x100>;
+			reg = <0x0 0xff7b0000 0x0 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>;
 
@@ -1339,7 +1339,7 @@
 
 		gpio5: gpio5 at ff7c0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7c0000 0x100>;
+			reg = <0x0 0xff7c0000 0x0 0x100>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO5>;
 
@@ -1352,7 +1352,7 @@
 
 		gpio6: gpio6 at ff7d0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7d0000 0x100>;
+			reg = <0x0 0xff7d0000 0x0 0x100>;
 			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO6>;
 
@@ -1365,7 +1365,7 @@
 
 		gpio7: gpio7 at ff7e0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7e0000 0x100>;
+			reg = <0x0 0xff7e0000 0x0 0x100>;
 			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO7>;
 
@@ -1378,7 +1378,7 @@
 
 		gpio8: gpio8 at ff7f0000 {
 			compatible = "rockchip,gpio-bank";
-			reg = <0xff7f0000 0x100>;
+			reg = <0x0 0xff7f0000 0x0 0x100>;
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO8>;
 
-- 
2.7.4
