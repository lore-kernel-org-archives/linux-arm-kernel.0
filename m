From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 20 Nov 2013 15:57:30 +0100
Subject: [PATCH 3/9] ARM: at91/dt: add usb1 vbus and pullup pins
In-Reply-To: <1377687881-10688-1-git-send-email-b.brezillon@overkiz.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
 <1377687881-10688-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <20131120145730.GD14627@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:04 Wed 28 Aug     , Boris BREZILLON wrote:
> Add vbus and pullup pinctrl definitions.
> Request the vbus and pullup pins in usb1 node.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>  arch/arm/boot/dts/at91rm9200ek.dts |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
> index 37b0880..76f3e87 100644
> --- a/arch/arm/boot/dts/at91rm9200ek.dts
> +++ b/arch/arm/boot/dts/at91rm9200ek.dts
> @@ -29,6 +29,18 @@
>  
>  	ahb {
>  		apb {
> +			pinctrl at fffff400 {
> +				usb1 {
> +					pinctrl_usb1_vbus: usb1_vbus-0 {
> +						atmel,pins = <AT91_PIOD 4 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> +					};

it's a gpio no-need
> +
> +					pinctrl_usb1_pullup: usb1_pullup-0 {
> +						atmel,pins = <AT91_PIOD 5 AT91_PERIPH_GPIO AT91_PINCTRL_MULTI_DRIVE>;
> +					};
no-need multidrive
> +				};
> +			};
> +
>  			dbgu: serial at fffff200 {
>  				status = "okay";
>  			};
> @@ -56,6 +68,9 @@
>  
>  			usb1: gadget at fffb0000 {
>  				atmel,vbus-gpio = <&pioD 4 GPIO_ACTIVE_HIGH>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_usb1_vbus
> +					     &pinctrl_usb1_pullup>;
>  				status = "okay";
>  			};
>  
> -- 
> 1.7.9.5
> 
