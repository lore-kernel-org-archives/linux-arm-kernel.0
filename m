From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 May 2012 15:11:59 +0200
Subject: [PATCH v3 3/3] ARM: dts: add nodes for atmel hsmci controllers
 for atmel platforms
In-Reply-To: <1337681352-18521-4-git-send-email-ludovic.desroches@atmel.com>
References: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com>
 <1337681352-18521-4-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4FBB909F.4090606@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2012 12:09 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Add nodes for mci controllers.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  arch/arm/boot/dts/at91sam9g20.dtsi     |   12 ++++++++++++

Maybe this one will have to be reworked on top of new ADC declarations.
Maybe also take into account the device tree support for sam9260: it is
linked with 9g20 support...

otherwise, once rebased you can add my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

(and I think that this one also should go through arm-soc)

>  arch/arm/boot/dts/at91sam9g25ek.dts    |   16 ++++++++++++++++
>  arch/arm/boot/dts/at91sam9g45.dtsi     |   24 ++++++++++++++++++++++++
>  arch/arm/boot/dts/at91sam9m10g45ek.dts |   17 +++++++++++++++++
>  arch/arm/boot/dts/at91sam9x5.dtsi      |   24 ++++++++++++++++++++++++
>  5 files changed, 93 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> index 773ef48..6a28bfe 100644
> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> @@ -197,6 +197,18 @@
>  				interrupts = <10 4>;
>  				status = "disabled";
>  			};
> +
> +			mmc0: mmc at fffa800 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xfffa800 0x600>;
> +				interrupts = <9 4>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				slot at 0 {
> +					reg = <0>;
> +				};
> +			};
>  		};
>  
>  		nand0: nand at 40000000 {
> diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
> index 7829a4d..dd94f4b 100644
> --- a/arch/arm/boot/dts/at91sam9g25ek.dts
> +++ b/arch/arm/boot/dts/at91sam9g25ek.dts
> @@ -32,6 +32,22 @@
>  				phy-mode = "rmii";
>  				status = "okay";
>  			};
> +
> +			mmc0: mmc at f0008000 {
> +				status = "okay";
> +				slot at 0 {
> +					bus-width = <4>;
> +					cd-gpios = <&pioD 15 0>;
> +				};
> +			};
> +
> +			mmc1: mmc at f000c000 {
> +				status = "okay";
> +				slot at 0 {
> +					bus-width = <4>;
> +					cd-gpios = <&pioD 14 0>;
> +				};
> +			};
>  		};
>  
>  		usb0: ohci at 00600000 {
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index c804214..2922648 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -199,6 +199,30 @@
>  				interrupts = <25 4>;
>  				status = "disabled";
>  			};
> +
> +			mmc0: mmc at fff80000 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xfff80000 0x600>;
> +				interrupts = <11 4>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				slot at 0 {
> +					reg = <0>;
> +				};
> +			};
> +
> +			mmc1: mmc at fffd0000 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xfffd0000 0x600>;
> +				interrupts = <29 4>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				slot at 0 {
> +					reg = <0>;
> +				};
> +			};
>  		};
>  
>  		nand0: nand at 40000000 {
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index a3633bd..bc4cb3c 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -46,6 +46,23 @@
>  				phy-mode = "rmii";
>  				status = "okay";
>  			};
> +
> +			mmc0: mmc at fff80000 {
> +				status = "okay";
> +				slot at 0 {
> +					bus-width = <4>;
> +					cd-gpios = <&pioD 10 0>;
> +				};
> +			};
> +
> +			mmc1: mmc at fffd0000 {
> +				status = "okay";
> +				slot at 0 {
> +					bus-width = <4>;
> +					cd-gpios = <&pioD 11 0>;
> +					wp-gpios = <&pioD 29 0>;
> +				};
> +			};
>  		};
>  
>  		nand0: nand at 40000000 {
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index dd4ed74..d5999b2 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -190,6 +190,30 @@
>  				interrupts = <27 4>;
>  				status = "disabled";
>  			};
> +
> +			mmc0: mmc at f0008000 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xf0008000 0x600>;
> +				interrupts = <12 4>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				slot at 0 {
> +					reg = <0>;
> +				};
> +			};
> +
> +			mmc1: mmc at f000c000 {
> +				compatible = "atmel,hsmci";
> +				reg = <0xf000c000 0x600>;
> +				interrupts = <26 4>;
> +				status = "disabled";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				slot at 0 {
> +					reg = <0>;
> +				};
> +			};
>  		};
>  
>  		nand0: nand at 40000000 {


-- 
Nicolas Ferre
