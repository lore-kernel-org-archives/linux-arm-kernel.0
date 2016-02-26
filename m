From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 22:35:11 +0100
Subject: [GIT PULL] omap device tree changes for v4.6 merge window, part 1
In-Reply-To: <20160222215612.GV13417@atomide.com>
References: <20160222215612.GV13417@atomide.com>
Message-ID: <6026634.ihuvqopRan@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 February 2016 13:56:12 Tony Lindgren wrote:
> Device tree changes for omaps for v4.6 merge window. Mostly just
> adding board specific devices and few new boards:
> 
> - N900 improvments for adp1653 and gpio keys
> 
> - Add missing bandgap data for omap3
> 
> - Add more devices for compulab cm-t335
> 
> - Add n950 WLAN support, enable modem, add pinctrl for SSI
> 
> - Correct dm814x and dra62x auxclk rate, add support for GPMC and NAND
> 
> - Add syscon node for PHY's on dra7
> 
> - Add support more devices on logicpd torpedo
> 
> - Add USB host support for igep and specify boot console
> 
> - Fix audio clock for am335x-sl50 and specify boot console
> 
> - Remove deprecated tx-fifo-resize for dwc3 that was only used on
>   omap5 es1.0
> 
> - Add dra7 thermal data
> 
> - Update am43x-epos-evm compatible string to am438
> 
> - Add support for logicpd dm3730 som-lv
> 

Pulled into next/dt, with a trivial conflict resolution:

--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@@ -110,6 -110,19 +110,11 @@@
  
  &i2c3 {
  	clock-frequency = <400000>;
 -};
 -
 -&i2c2 {
 -	clock-frequency = <400000>;
 -};
 -
 -&i2c3 {
 -	clock-frequency = <400000>;
+ 	at24 at 50 {
+ 		compatible = "at24,24c02";
+ 		readonly;
+ 		reg = <0x50>;
+ 	};
  };
  
  /*

Thanks,

	Arnd
