From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 20 Feb 2014 16:15:35 +0100
Subject: [PATCH 2/3] ARM: mvebu: use GIC_{SPI,PPI} in Armada 375/38x DTs
In-Reply-To: <1392894691-26837-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392894691-26837-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392894691-26837-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <53061C17.2040706@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 20/02/2014 12:11, Thomas Petazzoni wrote:
> Instead of hardcoding 0 and 1 to indicate SPI and PPI GIC interrupts,
> use the definitions of <dt-bindings/interrupt-controller/arm-gic.h> to
> clarify the Device Tree code.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-375.dtsi | 53 ++++++++++++++++++++-------------------
>  arch/arm/boot/dts/armada-380.dtsi |  6 ++---
>  arch/arm/boot/dts/armada-385.dtsi |  8 +++---
>  arch/arm/boot/dts/armada-38x.dtsi | 41 +++++++++++++++---------------
>  4 files changed, 55 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index c89fee4..23d497f 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -12,6 +12,7 @@
>   */
>  
>  #include "skeleton.dtsi"
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>  #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
>  
> @@ -129,7 +130,7 @@
>  			timer at c600 {
>  				compatible = "arm,cortex-a9-twd-timer";
>  				reg = <0xc600 0x20>;
> -				interrupts = <1 13 0x301>;
> +				interrupts = <GIC_PPI 13 0x301>;
>  				clocks = <&coreclk 2>;
>  			};
>  
> @@ -148,7 +149,7 @@
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				cell-index = <0>;
> -				interrupts = <0 1 0x4>;
> +				interrupts = <GIC_SPI 1 0x4>;
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
> @@ -159,7 +160,7 @@
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				cell-index = <1>;
> -				interrupts = <0 63 0x4>;
> +				interrupts = <GIC_SPI 63 0x4>;
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
> @@ -169,7 +170,7 @@
>  				reg = <0x11000 0x20>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				interrupts = <0 2 0x4>;
> +				interrupts = <GIC_SPI 2 0x4>;
>  				timeout-ms = <1000>;
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
> @@ -180,7 +181,7 @@
>  				reg = <0x11100 0x20>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				interrupts = <0 3 0x4>;
> +				interrupts = <GIC_SPI 3 0x4>;
>  				timeout-ms = <1000>;
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
> @@ -190,7 +191,7 @@
>  				compatible = "snps,dw-apb-uart";
>  				reg = <0x12000 0x100>;
>  				reg-shift = <2>;
> -				interrupts = <0 12 4>;
> +				interrupts = <GIC_SPI 12 4>;
>  				reg-io-width = <1>;
>  				status = "disabled";
>  			};
> @@ -199,7 +200,7 @@
>  				compatible = "snps,dw-apb-uart";
>  				reg = <0x12100 0x100>;
>  				reg-shift = <2>;
> -				interrupts = <0 13 4>;
> +				interrupts = <GIC_SPI 13 4>;
>  				reg-io-width = <1>;
>  				status = "disabled";
>  			};
> @@ -248,8 +249,8 @@
>  				#gpio-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> -				interrupts = <0 53 0x4>, <0 54 0x4>,
> -					     <0 55 0x4>, <0 56 0x4>;
> +				interrupts = <GIC_SPI 53 0x4>, <GIC_SPI 54 0x4>,
> +					     <GIC_SPI 55 0x4>, <GIC_SPI 56 0x4>;
>  			};
>  
>  			gpio1: gpio at 18140 {
> @@ -260,8 +261,8 @@
>  				#gpio-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> -				interrupts = <0 58 0x4>, <0 59 0x4>,
> -					     <0 60 0x4>, <0 61 0x4>;
> +				interrupts = <GIC_SPI 58 0x4>, <GIC_SPI 59 0x4>,
> +					     <GIC_SPI 60 0x4>, <GIC_SPI 61 0x4>;
>  			};
>  
>  			gpio2: gpio at 18180 {
> @@ -272,7 +273,7 @@
>  				#gpio-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> -				interrupts = <0 62 0x4>;
> +				interrupts = <GIC_SPI 62 0x4>;
>  			};
>  
>  			system-controller at 18200 {
> @@ -299,16 +300,16 @@
>  				#size-cells = <1>;
>  				interrupt-controller;
>  				msi-controller;
> -				interrupts = <1 15 0x4>;
> +				interrupts = <GIC_PPI 15 0x4>;
>  			};
>  
>  			timer at 20300 {
>  				compatible = "marvell,armada-375-timer", "marvell,armada-370-timer";
>  				reg = <0x20300 0x30>, <0x21040 0x30>;
> -				interrupts-extended = <&gic  0  8 4>,
> -						      <&gic  0  9 4>,
> -						      <&gic  0 10 4>,
> -						      <&gic  0 11 4>,
> +				interrupts-extended = <&gic  GIC_SPI  8 4>,
> +						      <&gic  GIC_SPI  9 4>,
> +						      <&gic  GIC_SPI 10 4>,
> +						      <&gic  GIC_SPI 11 4>,
>  						      <&mpic 5>,
>  						      <&mpic 6>;
>  				clocks = <&coreclk 0>;
> @@ -322,12 +323,12 @@
>  				status = "okay";
>  
>  				xor00 {
> -					interrupts = <0 22 0x4>;
> +					interrupts = <GIC_SPI 22 0x4>;
>  					dmacap,memcpy;
>  					dmacap,xor;
>  				};
>  				xor01 {
> -					interrupts = <0 23 0x4>;
> +					interrupts = <GIC_SPI 23 0x4>;
>  					dmacap,memcpy;
>  					dmacap,xor;
>  					dmacap,memset;
> @@ -342,12 +343,12 @@
>  				status = "okay";
>  
>  				xor10 {
> -					interrupts = <0 65 0x4>;
> +					interrupts = <GIC_SPI 65 0x4>;
>  					dmacap,memcpy;
>  					dmacap,xor;
>  				};
>  				xor11 {
> -					interrupts = <0 66 0x4>;
> +					interrupts = <GIC_SPI 66 0x4>;
>  					dmacap,memcpy;
>  					dmacap,xor;
>  					dmacap,memset;
> @@ -357,7 +358,7 @@
>  			sata at a0000 {
>  				compatible = "marvell,orion-sata";
>  				reg = <0xa0000 0x5000>;
> -				interrupts = <0 26 0x4>;
> +				interrupts = <GIC_SPI 26 0x4>;
>  				clocks = <&gateclk 14>, <&gateclk 20>;
>  				clock-names = "0", "1";
>  				status = "disabled";
> @@ -368,7 +369,7 @@
>  				reg = <0xd0000 0x54>;
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				interrupts = <0 84 0x4>;
> +				interrupts = <GIC_SPI 84 0x4>;
>  				clocks = <&gateclk 11>;
>  				status = "disabled";
>  			};
> @@ -376,7 +377,7 @@
>  			mvsdio at d4000 {
>  				compatible = "marvell,orion-sdio";
>  				reg = <0xd4000 0x200>;
> -				interrupts = <0 25 0x4>;
> +				interrupts = <GIC_SPI 25 0x4>;
>  				clocks = <&gateclk 17>;
>  				bus-width = <4>;
>  				cap-sdio-irq;
> @@ -429,7 +430,7 @@
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &gic 0 29 0x4>;
> +				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 0x4>;
>  				marvell,pcie-port = <0>;
>  				marvell,pcie-lane = <0>;
>  				clocks = <&gateclk 5>;
> @@ -446,7 +447,7 @@
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &gic 0 33 0x4>;
> +				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 0x4>;
>  				marvell,pcie-port = <0>;
>  				marvell,pcie-lane = <1>;
>  				clocks = <&gateclk 6>;
> diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
> index 82b3347..678ba3d 100644
> --- a/arch/arm/boot/dts/armada-380.dtsi
> +++ b/arch/arm/boot/dts/armada-380.dtsi
> @@ -70,7 +70,7 @@
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &gic 0 29 0x4>;
> +				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 0x4>;
>  				marvell,pcie-port = <0>;
>  				marvell,pcie-lane = <0>;
>  				clocks = <&gateclk 8>;
> @@ -88,7 +88,7 @@
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &gic 0 33 0x4>;
> +				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 0x4>;
>  				marvell,pcie-port = <1>;
>  				marvell,pcie-lane = <0>;
>  				clocks = <&gateclk 5>;
> @@ -106,7 +106,7 @@
>  				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
>  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &gic 0 70 0x4>;
> +				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 0x4>;
>  				marvell,pcie-port = <2>;
>  				marvell,pcie-lane = <0>;
>  				clocks = <&gateclk 6>;
> diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
> index b22f5f1..055bc2f 100644
> --- a/arch/arm/boot/dts/armada-385.dtsi
> +++ b/arch/arm/boot/dts/armada-385.dtsi
> @@ -81,7 +81,7 @@
>  				ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>  					  0x81000000 0 0 0x81000000 0x1 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &gic 0 29 0x4>;
> +				interrupt-map = <0 0 0 0 &gic GIC_SPI 29 0x4>;
>  				marvell,pcie-port = <0>;
>  				marvell,pcie-lane = <0>;
>  				clocks = <&gateclk 8>;
> @@ -99,7 +99,7 @@
>  				ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
>  					  0x81000000 0 0 0x81000000 0x2 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &gic 0 33 0x4>;
> +				interrupt-map = <0 0 0 0 &gic GIC_SPI 33 0x4>;
>  				marvell,pcie-port = <1>;
>  				marvell,pcie-lane = <0>;
>  				clocks = <&gateclk 5>;
> @@ -117,7 +117,7 @@
>  				ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
>  					  0x81000000 0 0 0x81000000 0x3 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &gic 0 70 0x4>;
> +				interrupt-map = <0 0 0 0 &gic GIC_SPI 70 0x4>;
>  				marvell,pcie-port = <2>;
>  				marvell,pcie-lane = <0>;
>  				clocks = <&gateclk 6>;
> @@ -138,7 +138,7 @@
>  				ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
>  					  0x81000000 0 0 0x81000000 0x4 0 1 0>;
>  				interrupt-map-mask = <0 0 0 0>;
> -				interrupt-map = <0 0 0 0 &gic 0 71 0x4>;
> +				interrupt-map = <0 0 0 0 &gic GIC_SPI 71 0x4>;
>  				marvell,pcie-port = <3>;
>  				marvell,pcie-lane = <0>;
>  				clocks = <&gateclk 7>;
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 5a10248..502d21a 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -13,6 +13,7 @@
>   */
>  
>  #include "skeleton.dtsi"
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>  #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
>  
> @@ -109,7 +110,7 @@
>  			timer at c600 {
>  				compatible = "arm,cortex-a9-twd-timer";
>  				reg = <0xc600 0x20>;
> -				interrupts = <1 13 0x301>;
> +				interrupts = <GIC_PPI 13 0x301>;
>  				clocks = <&coreclk 2>;
>  			};
>  
> @@ -128,7 +129,7 @@
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				cell-index = <0>;
> -				interrupts = <0 1 0x4>;
> +				interrupts = <GIC_SPI 1 0x4>;
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
> @@ -139,7 +140,7 @@
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				cell-index = <1>;
> -				interrupts = <0 63 0x4>;
> +				interrupts = <GIC_SPI 63 0x4>;
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
> @@ -149,7 +150,7 @@
>  				reg = <0x11000 0x20>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				interrupts = <0 2 0x4>;
> +				interrupts = <GIC_SPI 2 0x4>;
>  				timeout-ms = <1000>;
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
> @@ -160,7 +161,7 @@
>  				reg = <0x11100 0x20>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				interrupts = <0 3 0x4>;
> +				interrupts = <GIC_SPI 3 0x4>;
>  				timeout-ms = <1000>;
>  				clocks = <&coreclk 0>;
>  				status = "disabled";
> @@ -170,7 +171,7 @@
>  				compatible = "snps,dw-apb-uart";
>  				reg = <0x12000 0x100>;
>  				reg-shift = <2>;
> -				interrupts = <0 12 4>;
> +				interrupts = <GIC_SPI 12 4>;
>  				reg-io-width = <1>;
>  				status = "disabled";
>  			};
> @@ -179,7 +180,7 @@
>  				compatible = "snps,dw-apb-uart";
>  				reg = <0x12100 0x100>;
>  				reg-shift = <2>;
> -				interrupts = <0 13 4>;
> +				interrupts = <GIC_SPI 13 4>;
>  				reg-io-width = <1>;
>  				status = "disabled";
>  			};
> @@ -197,8 +198,8 @@
>  				#gpio-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> -				interrupts = <0 53 0x4>, <0 54 0x4>,
> -					     <0 55 0x4>, <0 56 0x4>;
> +				interrupts = <GIC_SPI 53 0x4>, <GIC_SPI 54 0x4>,
> +					     <GIC_SPI 55 0x4>, <GIC_SPI 56 0x4>;
>  			};
>  
>  			gpio1: gpio at 18140 {
> @@ -209,8 +210,8 @@
>  				#gpio-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> -				interrupts = <0 58 0x4>, <0 59 0x4>,
> -					     <0 60 0x4>, <0 61 0x4>;
> +				interrupts = <GIC_SPI 58 0x4>, <GIC_SPI 59 0x4>,
> +					     <GIC_SPI 60 0x4>, <GIC_SPI 61 0x4>;
>  			};
>  
>  			system-controller at 18200 {
> @@ -244,17 +245,17 @@
>  				#size-cells = <1>;
>  				interrupt-controller;
>  				msi-controller;
> -				interrupts = <1 15 0x4>;
> +				interrupts = <GIC_PPI 15 0x4>;
>  			};
>  
>  			timer at 20300 {
>  				compatible = "marvell,armada-380-timer",
>  					     "marvell,armada-xp-timer";
>  				reg = <0x20300 0x30>, <0x21040 0x30>;
> -				interrupts-extended = <&gic  0  8 4>,
> -						      <&gic  0  9 4>,
> -						      <&gic  0 10 4>,
> -						      <&gic  0 11 4>,
> +				interrupts-extended = <&gic  GIC_SPI  8 4>,
> +						      <&gic  GIC_SPI  9 4>,
> +						      <&gic  GIC_SPI 10 4>,
> +						      <&gic  GIC_SPI 11 4>,
>  						      <&mpic 5>,
>  						      <&mpic 6>;
>  				clocks = <&coreclk 2>, <&refclk>;
> @@ -285,12 +286,12 @@
>  				status = "okay";
>  
>  				xor00 {
> -					interrupts = <0 22 0x4>;
> +					interrupts = <GIC_SPI 22 0x4>;
>  					dmacap,memcpy;
>  					dmacap,xor;
>  				};
>  				xor01 {
> -					interrupts = <0 23 0x4>;
> +					interrupts = <GIC_SPI 23 0x4>;
>  					dmacap,memcpy;
>  					dmacap,xor;
>  					dmacap,memset;
> @@ -305,12 +306,12 @@
>  				status = "okay";
>  
>  				xor10 {
> -					interrupts = <0 65 0x4>;
> +					interrupts = <GIC_SPI 65 0x4>;
>  					dmacap,memcpy;
>  					dmacap,xor;
>  				};
>  				xor11 {
> -					interrupts = <0 66 0x4>;
> +					interrupts = <GIC_SPI 66 0x4>;
>  					dmacap,memcpy;
>  					dmacap,xor;
>  					dmacap,memset;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
