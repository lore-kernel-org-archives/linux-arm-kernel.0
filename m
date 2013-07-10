From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 10 Jul 2013 16:38:35 +0200
Subject: [PATCH 2/3] arm: atmel: at91sam9n12: add qt1070 support
In-Reply-To: <1373449869-5083-3-git-send-email-voice.shen@atmel.com>
References: <1373449869-5083-1-git-send-email-voice.shen@atmel.com>
 <1373449869-5083-3-git-send-email-voice.shen@atmel.com>
Message-ID: <20130710143835.GG18012@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:51 Wed 10 Jul     , Bo Shen wrote:
> add qt1070 support on at91sam9n12ek board
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
>  arch/arm/boot/dts/at91sam9n12ek.dts |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> index d59b70c..3acac62 100644
> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -40,6 +40,15 @@
>  
>  			i2c0: i2c at f8010000 {
>  				status = "okay";
> +
> +				qt1070: keyboard at 1b {
> +					compatible = "qt1070";
> +					reg = <0x1b>;
> +					interrupt-parent = <&pioA>;
> +					interrupts = <2 0x0>;
use the macro
> +					pinctrl-names = "default";
> +					pinctrl-0 = <&pinctrl_qt1070_irq>;
> +				};
>  			};
>  
>  			i2c1: i2c at f8014000 {
> @@ -66,6 +75,13 @@
>  							<AT91_PIOA 7 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;	/* PA7 gpio CD pin pull up and deglitch */
>  					};
>  				};
> +
> +				qt1070 {
> +					pinctrl_qt1070_irq: qt1070_irq {
> +						atmel,pins =
> +							<AT91_PIOA 2 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>; /* PA2 GPIO with pull up deglith */
drop the comment as we use macro
> +					};
> +				};
>  			};
>  
>  			spi0: spi at f0000000 {
> -- 

Best Regards,
J.
