From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  6 Sep 2016 02:17:14 +0800
Subject: [PATCH v3 1/2] arm64: dts: rockchip: change all interrupts cells for
 4 on rk3399 SoCs
In-Reply-To: <1473099435-28198-1-git-send-email-wxt@rock-chips.com>
References: <1473099435-28198-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1473099435-28198-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the interrupts cells value for 4, and the 4th cell is zero.

Due to the doc[0] said:" the system requires describing PPI affinity,
then the value must be at least 4"
The 4th cell is a phandle to a node describing a set of CPUs this
interrupt is affine to. The interrupt must be a PPI, and the node
pointed must be a subnode of the "ppi-partitions" subnode. For
interrupt types other than PPI or PPIs that are not partitionned,
this cell must be zero. See the "ppi-partitions" node description
below.

[0]:
Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
CC: linux-arm-kernel at lists.infradead.org

---

Changes in v3:
- update with the lastest next kernel(20160905).
- add Mark's ACK for PATCH[1/2].

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 102 +++++++++++++++----------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 6c89d77..e9e22fe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -160,10 +160,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
 	};
 
 	xin24m: xin24m {
@@ -182,8 +182,8 @@
 		dmac_bus: dma-controller at ff6d0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x0 0xff6d0000 0x0 0x4000>;
-			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH 0>;
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMAC0_PERILP>;
 			clock-names = "apb_pclk";
@@ -192,8 +192,8 @@
 		dmac_peri: dma-controller at ff6e0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x0 0xff6e0000 0x0 0x4000>;
-			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH 0>;
 			#dma-cells = <1>;
 			clocks = <&cru ACLK_DMAC1_PERILP>;
 			clock-names = "apb_pclk";
@@ -204,7 +204,7 @@
 		compatible = "rockchip,rk3399-dw-mshc",
 			     "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe310000 0x0 0x4000>;
-		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH 0>;
 		clock-freq-min-max = <400000 150000000>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
@@ -217,7 +217,7 @@
 		compatible = "rockchip,rk3399-dw-mshc",
 			     "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe320000 0x0 0x4000>;
-		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH 0>;
 		clock-freq-min-max = <400000 150000000>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
@@ -229,7 +229,7 @@
 	sdhci: sdhci at fe330000 {
 		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
 		reg = <0x0 0xfe330000 0x0 0x10000>;
-		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH 0>;
 		arasan,soc-ctl-syscon = <&grf>;
 		assigned-clocks = <&cru SCLK_EMMC>;
 		assigned-clock-rates = <200000000>;
@@ -284,7 +284,7 @@
 	usb_host0_ehci: usb at fe380000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xfe380000 0x0 0x20000>;
-		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>;
 		clock-names = "hclk_host0", "hclk_host0_arb";
 		phys = <&u2phy0_host>;
@@ -295,7 +295,7 @@
 	usb_host0_ohci: usb at fe3a0000 {
 		compatible = "generic-ohci";
 		reg = <0x0 0xfe3a0000 0x0 0x20000>;
-		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>;
 		clock-names = "hclk_host0", "hclk_host0_arb";
 		status = "disabled";
@@ -304,7 +304,7 @@
 	usb_host1_ehci: usb at fe3c0000 {
 		compatible = "generic-ehci";
 		reg = <0x0 0xfe3c0000 0x0 0x20000>;
-		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>;
 		clock-names = "hclk_host1", "hclk_host1_arb";
 		phys = <&u2phy1_host>;
@@ -315,7 +315,7 @@
 	usb_host1_ohci: usb at fe3e0000 {
 		compatible = "generic-ohci";
 		reg = <0x0 0xfe3e0000 0x0 0x20000>;
-		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>;
 		clock-names = "hclk_host1", "hclk_host1_arb";
 		status = "disabled";
@@ -334,7 +334,7 @@
 		      <0x0 0xfff00000 0 0x10000>, /* GICC */
 		      <0x0 0xfff10000 0 0x10000>, /* GICH */
 		      <0x0 0xfff20000 0 0x10000>; /* GICV */
-		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
 		its: interrupt-controller at fee20000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
@@ -345,7 +345,7 @@
 	saradc: saradc at ff100000 {
 		compatible = "rockchip,rk3399-saradc";
 		reg = <0x0 0xff100000 0x0 0x100>;
-		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH 0>;
 		#io-channel-cells = <1>;
 		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
 		clock-names = "saradc", "apb_pclk";
@@ -361,7 +361,7 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_I2C1>, <&cru PCLK_I2C1>;
 		clock-names = "i2c", "pclk";
-		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c1_xfer>;
 		#address-cells = <1>;
@@ -376,7 +376,7 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_I2C2>, <&cru PCLK_I2C2>;
 		clock-names = "i2c", "pclk";
-		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c2_xfer>;
 		#address-cells = <1>;
@@ -391,7 +391,7 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_I2C3>, <&cru PCLK_I2C3>;
 		clock-names = "i2c", "pclk";
-		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c3_xfer>;
 		#address-cells = <1>;
@@ -406,7 +406,7 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_I2C5>, <&cru PCLK_I2C5>;
 		clock-names = "i2c", "pclk";
-		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c5_xfer>;
 		#address-cells = <1>;
@@ -421,7 +421,7 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_I2C6>, <&cru PCLK_I2C6>;
 		clock-names = "i2c", "pclk";
-		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c6_xfer>;
 		#address-cells = <1>;
@@ -436,7 +436,7 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_I2C7>, <&cru PCLK_I2C7>;
 		clock-names = "i2c", "pclk";
-		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c7_xfer>;
 		#address-cells = <1>;
@@ -449,7 +449,7 @@
 		reg = <0x0 0xff180000 0x0 0x100>;
 		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
 		clock-names = "baudclk", "apb_pclk";
-		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
@@ -462,7 +462,7 @@
 		reg = <0x0 0xff190000 0x0 0x100>;
 		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
 		clock-names = "baudclk", "apb_pclk";
-		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
@@ -475,7 +475,7 @@
 		reg = <0x0 0xff1a0000 0x0 0x100>;
 		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
 		clock-names = "baudclk", "apb_pclk";
-		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
@@ -488,7 +488,7 @@
 		reg = <0x0 0xff1b0000 0x0 0x100>;
 		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
 		clock-names = "baudclk", "apb_pclk";
-		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
@@ -501,7 +501,7 @@
 		reg = <0x0 0xff1c0000 0x0 0x1000>;
 		clocks = <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
 		clock-names = "spiclk", "apb_pclk";
-		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0>;
 		#address-cells = <1>;
@@ -514,7 +514,7 @@
 		reg = <0x0 0xff1d0000 0x0 0x1000>;
 		clocks = <&cru SCLK_SPI1>, <&cru PCLK_SPI1>;
 		clock-names = "spiclk", "apb_pclk";
-		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi1_clk &spi1_tx &spi1_rx &spi1_cs0>;
 		#address-cells = <1>;
@@ -527,7 +527,7 @@
 		reg = <0x0 0xff1e0000 0x0 0x1000>;
 		clocks = <&cru SCLK_SPI2>, <&cru PCLK_SPI2>;
 		clock-names = "spiclk", "apb_pclk";
-		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi2_clk &spi2_tx &spi2_rx &spi2_cs0>;
 		#address-cells = <1>;
@@ -540,7 +540,7 @@
 		reg = <0x0 0xff1f0000 0x0 0x1000>;
 		clocks = <&cru SCLK_SPI4>, <&cru PCLK_SPI4>;
 		clock-names = "spiclk", "apb_pclk";
-		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi4_clk &spi4_tx &spi4_rx &spi4_cs0>;
 		#address-cells = <1>;
@@ -553,7 +553,7 @@
 		reg = <0x0 0xff200000 0x0 0x1000>;
 		clocks = <&cru SCLK_SPI5>, <&cru PCLK_SPI5>;
 		clock-names = "spiclk", "apb_pclk";
-		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi5_clk &spi5_tx &spi5_rx &spi5_cs0>;
 		#address-cells = <1>;
@@ -633,7 +633,7 @@
 	tsadc: tsadc at ff260000 {
 		compatible = "rockchip,rk3399-tsadc";
 		reg = <0x0 0xff260000 0x0 0x100>;
-		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH 0>;
 		assigned-clocks = <&cru SCLK_TSADC>;
 		assigned-clock-rates = <750000>;
 		clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
@@ -864,7 +864,7 @@
 		reg = <0x0 0xff350000 0x0 0x1000>;
 		clocks = <&pmucru SCLK_SPI3_PMU>, <&pmucru PCLK_SPI3_PMU>;
 		clock-names = "spiclk", "apb_pclk";
-		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi3_clk &spi3_tx &spi3_rx &spi3_cs0>;
 		#address-cells = <1>;
@@ -877,7 +877,7 @@
 		reg = <0x0 0xff370000 0x0 0x100>;
 		clocks = <&pmucru SCLK_UART4_PMU>, <&pmucru PCLK_UART4_PMU>;
 		clock-names = "baudclk", "apb_pclk";
-		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH 0>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		pinctrl-names = "default";
@@ -892,7 +892,7 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&pmucru SCLK_I2C0_PMU>, <&pmucru PCLK_I2C0_PMU>;
 		clock-names = "i2c", "pclk";
-		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c0_xfer>;
 		#address-cells = <1>;
@@ -907,7 +907,7 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&pmucru SCLK_I2C4_PMU>, <&pmucru PCLK_I2C4_PMU>;
 		clock-names = "i2c", "pclk";
-		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c4_xfer>;
 		#address-cells = <1>;
@@ -922,7 +922,7 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&pmucru SCLK_I2C8_PMU>, <&pmucru PCLK_I2C8_PMU>;
 		clock-names = "i2c", "pclk";
-		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c8_xfer>;
 		#address-cells = <1>;
@@ -1057,7 +1057,7 @@
 
 			u2phy0_host: host-port {
 				#phy-cells = <0>;
-				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH 0>;
 				interrupt-names = "linestate";
 				status = "disabled";
 			};
@@ -1074,7 +1074,7 @@
 
 			u2phy1_host: host-port {
 				#phy-cells = <0>;
-				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH 0>;
 				interrupt-names = "linestate";
 				status = "disabled";
 			};
@@ -1104,13 +1104,13 @@
 		compatible = "snps,dw-wdt";
 		reg = <0x0 0xff848000 0x0 0x100>;
 		clocks = <&cru PCLK_WDT>;
-		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH 0>;
 	};
 
 	rktimer: rktimer at ff850000 {
 		compatible = "rockchip,rk3399-timer";
 		reg = <0x0 0xff850000 0x0 0x1000>;
-		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_TIMER0>, <&cru SCLK_TIMER00>;
 		clock-names = "pclk", "timer";
 	};
@@ -1118,7 +1118,7 @@
 	spdif: spdif at ff870000 {
 		compatible = "rockchip,rk3399-spdif";
 		reg = <0x0 0xff870000 0x0 0x1000>;
-		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH 0>;
 		dmas = <&dmac_bus 7>;
 		dma-names = "tx";
 		clock-names = "mclk", "hclk";
@@ -1132,7 +1132,7 @@
 		compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
 		reg = <0x0 0xff880000 0x0 0x1000>;
 		rockchip,grf = <&grf>;
-		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH 0>;
 		dmas = <&dmac_bus 0>, <&dmac_bus 1>;
 		dma-names = "tx", "rx";
 		clock-names = "i2s_clk", "i2s_hclk";
@@ -1145,7 +1145,7 @@
 	i2s1: i2s at ff890000 {
 		compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
 		reg = <0x0 0xff890000 0x0 0x1000>;
-		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH 0>;
 		dmas = <&dmac_bus 2>, <&dmac_bus 3>;
 		dma-names = "tx", "rx";
 		clock-names = "i2s_clk", "i2s_hclk";
@@ -1158,7 +1158,7 @@
 	i2s2: i2s at ff8a0000 {
 		compatible = "rockchip,rk3399-i2s", "rockchip,rk3066-i2s";
 		reg = <0x0 0xff8a0000 0x0 0x1000>;
-		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH 0>;
 		dmas = <&dmac_bus 4>, <&dmac_bus 5>;
 		dma-names = "tx", "rx";
 		clock-names = "i2s_clk", "i2s_hclk";
@@ -1178,7 +1178,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff720000 0x0 0x100>;
 			clocks = <&pmucru PCLK_GPIO0_PMU>;
-			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH 0>;
 
 			gpio-controller;
 			#gpio-cells = <0x2>;
@@ -1191,7 +1191,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff730000 0x0 0x100>;
 			clocks = <&pmucru PCLK_GPIO1_PMU>;
-			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH 0>;
 
 			gpio-controller;
 			#gpio-cells = <0x2>;
@@ -1204,7 +1204,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff780000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO2>;
-			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH 0>;
 
 			gpio-controller;
 			#gpio-cells = <0x2>;
@@ -1217,7 +1217,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff788000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO3>;
-			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH 0>;
 
 			gpio-controller;
 			#gpio-cells = <0x2>;
@@ -1230,7 +1230,7 @@
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xff790000 0x0 0x100>;
 			clocks = <&cru PCLK_GPIO4>;
-			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
 
 			gpio-controller;
 			#gpio-cells = <0x2>;
-- 
1.9.1
