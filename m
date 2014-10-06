From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 6 Oct 2014 16:12:03 +0200
Subject: [PATCH v2 1/1] ARM: at91/dt: sam9x5: Add CAN device nodes
In-Reply-To: <1412248785-28269-1-git-send-email-alexander.stein@systec-electronic.com>
References: <20141002105716.GG3907@piout.net>
 <1412248785-28269-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20141006141203.GB15599@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/10/2014 at 13:19:45 +0200, Alexander Stein wrote :
> Add the missing CAN devices node including their pin muxing and clocks.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Changes in v2:
> * Adjusted pinmux comment
> 
>  arch/arm/boot/dts/at91sam9x5.dtsi | 48 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index e1a5c70..e3f11f2 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -763,6 +795,22 @@
>  					};
>  				};
>  
> +				can0 {
> +					pinctrl_can0_rx_tx: can0_rx_tx {
> +						atmel,pins =
> +							<AT91_PIOA 9 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX, conflicts with DRXD */
> +							 AT91_PIOA 10 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* CANTX, conflicts with DTXD */

Last nitpick, could you make that be CANRX0 and CANTX0 ?

> +					};
> +				};
> +
> +				can1 {
> +					pinctrl_can1_rx_tx: can1_rx_tx {
> +						atmel,pins =
> +							<AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_NONE	/* CANRX, conflicts with RXD1 */
> +							 AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* CANTX, conflicts with TXD1 */

And CANRX1, CANTX1 here so that it is the same as the datasheet.

Then you can add my acked-by.

Thanks !

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
