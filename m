From: rjui@broadcom.com (Ray Jui)
Date: Mon, 21 Sep 2015 15:12:45 -0700
Subject: [PATCH v3 4/9] ARM: dts: Move all Cygnus peripherals into axi bus
In-Reply-To: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
References: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442873570-20947-5-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move all Cygnus peripherals to be under the "axi" bus node of type
"simple-bus"

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 279 +++++++++++++++++++-------------------
 1 file changed, 140 insertions(+), 139 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 97fd305..5ee7543 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -88,173 +88,174 @@
 		};
 	};
 
-	pinctrl: pinctrl at 0x0301d0c8 {
-		compatible = "brcm,cygnus-pinmux";
-		reg = <0x0301d0c8 0x30>,
-		      <0x0301d24c 0x2c>;
-	};
+	axi {
+		compatible = "simple-bus";
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
 
-	gpio_crmu: gpio at 03024800 {
-		compatible = "brcm,cygnus-crmu-gpio";
-		reg = <0x03024800 0x50>,
-		      <0x03024008 0x18>;
-		#gpio-cells = <2>;
-		gpio-controller;
-	};
+		pinctrl: pinctrl at 0x0301d0c8 {
+			compatible = "brcm,cygnus-pinmux";
+			reg = <0x0301d0c8 0x30>,
+			      <0x0301d24c 0x2c>;
+		};
 
-	gpio_ccm: gpio at 1800a000 {
-		compatible = "brcm,cygnus-ccm-gpio";
-		reg = <0x1800a000 0x50>,
-		      <0x0301d164 0x20>;
-		#gpio-cells = <2>;
-		gpio-controller;
-		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-	};
+		gpio_crmu: gpio at 03024800 {
+			compatible = "brcm,cygnus-crmu-gpio";
+			reg = <0x03024800 0x50>,
+			      <0x03024008 0x18>;
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
 
-	gpio_asiu: gpio at 180a5000 {
-		compatible = "brcm,cygnus-asiu-gpio";
-		reg = <0x180a5000 0x668>;
-		#gpio-cells = <2>;
-		gpio-controller;
+		gpio_ccm: gpio at 1800a000 {
+			compatible = "brcm,cygnus-ccm-gpio";
+			reg = <0x1800a000 0x50>,
+			      <0x0301d164 0x20>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+		};
 
-		pinmux = <&pinctrl>;
+		gpio_asiu: gpio at 180a5000 {
+			compatible = "brcm,cygnus-asiu-gpio";
+			reg = <0x180a5000 0x668>;
+			#gpio-cells = <2>;
+			gpio-controller;
 
-		interrupt-controller;
-		interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-	};
+			pinmux = <&pinctrl>;
 
-	amba {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "arm,amba-bus", "simple-bus";
-		interrupt-parent = <&gic>;
-		ranges;
+			interrupt-controller;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+		};
 
-		wdt at 18009000 {
-			 compatible = "arm,sp805" , "arm,primecell";
-			 reg = <0x18009000 0x1000>;
-			 interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-			 clocks = <&axi81_clk>;
-			 clock-names = "apb_pclk";
+		wdt0: wdt at 18009000 {
+			compatible = "arm,sp805" , "arm,primecell";
+			reg = <0x18009000 0x1000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-names = "apb_pclk";
 		};
-	};
 
-	i2c0: i2c at 18008000 {
-		compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
-		reg = <0x18008000 0x100>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
-		clock-frequency = <100000>;
-		status = "disabled";
-	};
+		i2c0: i2c at 18008000 {
+			compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
+			reg = <0x18008000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
 
-	i2c1: i2c at 1800b000 {
-		compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
-		reg = <0x1800b000 0x100>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
-		clock-frequency = <100000>;
-		status = "disabled";
-	};
+		i2c1: i2c at 1800b000 {
+			compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
+			reg = <0x1800b000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+			status = "disabled";
+		};
 
-	pcie0: pcie at 18012000 {
-		compatible = "brcm,iproc-pcie";
-		reg = <0x18012000 0x1000>;
+		pcie0: pcie at 18012000 {
+			compatible = "brcm,iproc-pcie";
+			reg = <0x18012000 0x1000>;
 
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
 
-		linux,pci-domain = <0>;
+			linux,pci-domain = <0>;
 
-		bus-range = <0x00 0xff>;
+			bus-range = <0x00 0xff>;
 
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
-			  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
+				  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
 
-		status = "disabled";
-	};
+			status = "disabled";
+		};
 
-	pcie1: pcie at 18013000 {
-		compatible = "brcm,iproc-pcie";
-		reg = <0x18013000 0x1000>;
+		pcie1: pcie at 18013000 {
+			compatible = "brcm,iproc-pcie";
+			reg = <0x18013000 0x1000>;
 
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
 
-		linux,pci-domain = <1>;
+			linux,pci-domain = <1>;
 
-		bus-range = <0x00 0xff>;
+			bus-range = <0x00 0xff>;
 
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
-			  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
+				  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
 
-		status = "disabled";
-	};
+			status = "disabled";
+		};
 
-	uart0: serial at 18020000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x18020000 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&axi81_clk>;
-		clock-frequency = <100000000>;
-		status = "disabled";
-	};
+		uart0: serial at 18020000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x18020000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
 
-	uart1: serial at 18021000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x18021000 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&axi81_clk>;
-		clock-frequency = <100000000>;
-		status = "disabled";
-	};
+		uart1: serial at 18021000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x18021000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
 
-	uart2: serial at 18022000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x18020000 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&axi81_clk>;
-		clock-frequency = <100000000>;
-		status = "disabled";
-	};
+		uart2: serial at 18022000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x18020000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
 
-	uart3: serial at 18023000 {
-		compatible = "snps,dw-apb-uart";
-		reg = <0x18023000 0x100>;
-		reg-shift = <2>;
-		reg-io-width = <4>;
-		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&axi81_clk>;
-		clock-frequency = <100000000>;
-		status = "disabled";
-	};
+		uart3: serial at 18023000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x18023000 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&axi81_clk>;
+			clock-frequency = <100000000>;
+			status = "disabled";
+		};
 
-	nand: nand at 18046000 {
-		compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1", "brcm,brcmnand";
-		reg = <0x18046000 0x600>, <0xf8105408 0x600>, <0x18046f00 0x20>;
-		reg-names = "nand", "iproc-idm", "iproc-ext";
-		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		nand: nand at 18046000 {
+			compatible = "brcm,nand-iproc", "brcm,brcmnand-v6.1",
+				     "brcm,brcmnand";
+			reg = <0x18046000 0x600>, <0xf8105408 0x600>,
+			      <0x18046f00 0x20>;
+			reg-names = "nand", "iproc-idm", "iproc-ext";
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 
-		#address-cells = <1>;
-		#size-cells = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-		brcm,nand-has-wp;
+			brcm,nand-has-wp;
+		};
 	};
 };
-- 
1.9.1
