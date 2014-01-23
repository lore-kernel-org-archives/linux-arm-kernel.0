From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 23 Jan 2014 11:23:05 +1100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20140123112305.56edc8c80ce536c40221b544@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/bcm11351.dtsi between commit 67a57be85e68 ("ARM:
bcm11351: Enable pinctrl for Broadcom Capri SoCs") from Linus' tree and
commit 0bd898b872ac ("ARM: dts: Declare clocks as fixed on bcm11351") and
several following commits from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/bcm11351.dtsi
index dd8e878741c0,375a2f8eb878..000000000000
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@@ -142,8 -146,159 +146,164 @@@
  		status = "disabled";
  	};
  
 +	pinctrl at 35004800 {
 +		compatible = "brcm,capri-pinctrl";
 +		reg = <0x35004800 0x430>;
 +	};
++
+ 	i2c at 3e016000 {
+ 		compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
+ 		reg = <0x3e016000 0x80>;
+ 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+ 		#address-cells = <1>;
+ 		#size-cells = <0>;
+ 		clocks = <&bsc1_clk>;
+ 		status = "disabled";
+ 	};
+ 
+ 	i2c at 3e017000 {
+ 		compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
+ 		reg = <0x3e017000 0x80>;
+ 		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+ 		#address-cells = <1>;
+ 		#size-cells = <0>;
+ 		clocks = <&bsc2_clk>;
+ 		status = "disabled";
+ 	};
+ 
+ 	i2c at 3e018000 {
+ 		compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
+ 		reg = <0x3e018000 0x80>;
+ 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+ 		#address-cells = <1>;
+ 		#size-cells = <0>;
+ 		clocks = <&bsc3_clk>;
+ 		status = "disabled";
+ 	};
+ 
+ 	i2c at 3500d000 {
+ 		compatible = "brcm,bcm11351-i2c", "brcm,kona-i2c";
+ 		reg = <0x3500d000 0x80>;
+ 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+ 		#address-cells = <1>;
+ 		#size-cells = <0>;
+ 		clocks = <&pmu_bsc_clk>;
+ 		status = "disabled";
+ 	};
+ 
+ 	clocks {
+ 		bsc1_clk: bsc1 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <13000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		bsc2_clk: bsc2 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <13000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		bsc3_clk: bsc3 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <13000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		pmu_bsc_clk: pmu_bsc {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <13000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		hub_timer_clk: hub_timer {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <32768>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		pwm_clk: pwm {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <26000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		sdio1_clk: sdio1 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <48000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		sdio2_clk: sdio2 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <48000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		sdio3_clk: sdio3 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <48000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		sdio4_clk: sdio4 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <48000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		tmon_1m_clk: tmon_1m {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <1000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		uartb_clk: uartb {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <13000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		uartb2_clk: uartb2 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <13000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		uartb3_clk: uartb3 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <13000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		uartb4_clk: uartb4 {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <13000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 
+ 		usb_otg_ahb_clk: usb_otg_ahb {
+ 			compatible = "fixed-clock";
+ 			clock-frequency = <52000000>;
+ 			#clock-cells = <0>;
+ 		};
+ 	};
+ 
+ 	usbotg: usb at 3f120000 {
+ 		compatible = "snps,dwc2";
+ 		reg = <0x3f120000 0x10000>;
+ 		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+ 		clocks = <&usb_otg_ahb_clk>;
+ 		clock-names = "otg";
+ 		phys = <&usbphy>;
+ 		phy-names = "usb2-phy";
+ 		status = "disabled";
+ 	};
+ 
+ 	usbphy: usb-phy at 3f130000 {
+ 		compatible = "brcm,kona-usb2-phy";
+ 		reg = <0x3f130000 0x28>;
+ 		#phy-cells = <0>;
+ 		status = "disabled";
+ 	};
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140123/56f7fd1b/attachment.sig>
