From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 2 Oct 2014 12:57:16 +0200
Subject: [PATCH 1/1] ARM: at91/dt: sam9x5: Add CAN device nodes
In-Reply-To: <1412246294-27370-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1412246294-27370-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20141002105716.GG3907@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/10/2014 at 12:38:14 +0200, Alexander Stein wrote :
> Add the missing CAN devices node including their pin muxing and clocks.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> I could actually only test CAN1 due to the hardware I had available. Also
> CAN0 conflicts with DBGU pins, which I had to use.
> 
>  arch/arm/boot/dts/at91sam9x5.dtsi | 48 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index e1a5c70..0a2164e 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -763,6 +795,22 @@
>  					};
>  				};
>  
> +				can0 {
> +					pinctrl_can0_rx_tx: can0_rx_tx {
> +						atmel,pins =
> +							<AT91_PIOA 9 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PA9 periph B RX */
> +							 AT91_PIOA 10 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA10 periph B TX */

I would stop adding that comment as this is pretty clear that your are
setting PA9 and P10 to periph B. A more useful kind of comment is what
pin it conflicts with. Maybe something like:

							<AT91_PIOA 9 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX0, conflicts with DRXD */

> +					};
> +				};
> +
> +				can1 {
> +					pinctrl_can1_rx_tx: can1_rx_tx {
> +						atmel,pins =
> +							<AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PA6 periph B RX */
> +							 AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA5 periph B TX */

ditto

> +					};
> +				};
> +
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> -- 
> 2.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
