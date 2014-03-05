From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 5 Mar 2014 10:22:11 +0100
Subject: [PATCH 2/2] ARM: dts: sama5d36ek: add spi pinctrl sleep state
In-Reply-To: <1393984730-14828-3-git-send-email-wenyou.yang@atmel.com>
References: <1393984730-14828-1-git-send-email-wenyou.yang@atmel.com>
 <1393984730-14828-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20140305092211.GB4441@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/03/2014 at 09:58:50 +0800, Wenyou Yang wrote :
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>  arch/arm/boot/dts/sama5d36ek.dts |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d36ek.dts b/arch/arm/boot/dts/sama5d36ek.dts
> index 59576c6..676d121 100644
> --- a/arch/arm/boot/dts/sama5d36ek.dts
> +++ b/arch/arm/boot/dts/sama5d36ek.dts
> @@ -18,6 +18,8 @@
>  	ahb {
>  		apb {
>  			spi0: spi at f0004000 {
> +				pinctrl-names = "default", "sleep";
> +				pinctrl-1 = <&pinctrl_spi0_sleep>;
>  				status = "okay";
>  			};
>  
> @@ -44,6 +46,18 @@
>  			macb1: ethernet at f802c000 {
>  				status = "okay";
>  			};
> +
> +			pinctrl at fffff200 {
> +				spi0 {
> +					pinctrl_spi0_sleep: spi0-1 {
> +						atmel,pins =
> +							<AT91_PIOD 10 AT91_PERIPH_GPIO AT91_PINCTRL_OUTPUT_LOW	/* PD10 GPIO Output Low */
> +							 AT91_PIOD 11 AT91_PERIPH_GPIO AT91_PINCTRL_OUTPUT_LOW	/* PD11 GPIO Output Low */
> +							 AT91_PIOD 12 AT91_PERIPH_GPIO AT91_PINCTRL_OUTPUT_LOW>;	/* PD12 GPIO Output Low */

I think that one would belong to the dtsi as this is generic enough.

Also, it was suggested by Mark that list entries should be bracketed
separately. But I guess we may not want to mix styles in the same file.
Nicolas, what do you think ?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
