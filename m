From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jan 2015 11:43:04 +0100
Subject: [PATCH v2] AT91, DT, usb gadget: disable pull-up on vbus-gpio
 (PB16) to reduce power consumption
In-Reply-To: <1421401839-29370-1-git-send-email-sylvain.rochet@finsecur.com>
References: <54B8AE36.6090904@atmel.com>
 <1421401839-29370-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150116104304.GC3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/2015 at 10:50:39 +0100, Sylvain Rochet wrote :
> There is an external resistor divider on PB16, acting like a pull-down,
> the pull-up increase power consumption and prevent the vbus detect pin
> to reach Vss voltage, ~1.5V mesured on my board, it might not even work
> if the pull-up is stronger than usual.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

You should have added the ack from Bo here too.

> ---
> Improved GPIO comment, fixed typo in commit summary.
> 
>  arch/arm/boot/dts/at91sam9x5ek.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> index 3a9f6fa..bd16bd3 100644
> --- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> @@ -53,6 +53,8 @@
>  			};
>  
>  			usb2: gadget at f803c000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_board_usb2>;
>  				atmel,vbus-gpio = <&pioB 16 GPIO_ACTIVE_HIGH>;
>  				status = "okay";
>  			};
> @@ -80,6 +82,13 @@
>  							<AT91_PIOD 14 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH>;	/* PD14 gpio CD pin pull up and deglitch */
>  					};
>  				};
> +
> +				usb2 {
> +					pinctrl_board_usb2: usb2-board {
> +						atmel,pins =
> +							<AT91_PIOB 16 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;		/* PB16 gpio vbus sense, deglitch */
> +					};
> +				};
>  			};
>  
>  			spi0: spi at f0000000 {
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
