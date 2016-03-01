From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 1 Mar 2016 10:48:05 +0100
Subject: [PATCH] ARM: dts: at91: sama5d2 Xplained: Correct the macb irq
 pinctrl node
In-Reply-To: <1455790866-13301-1-git-send-email-romain.izard.pro@gmail.com>
References: <1455790866-13301-1-git-send-email-romain.izard.pro@gmail.com>
Message-ID: <56D56555.1030703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/02/2016 11:21, Romain Izard a ?crit :
> All pinctrl nodes for the Atmel pinctrl controller need to have their
> bias configuration explicitly defined. Otherwise, the pinctrl mapping
> is not valid.
> 
> It works for now as the pinctrl driver proceeds even with invalid
> mappings, but this can become an issue, if the pinctrl driver starts
> to require valid mappings. Additionally, the pin is not protected from
> being remapped later by an other driver.
> 
> There is an external 1k? pull-up to 3.3V, so no bias is required on
> the Ethernet PHY's interrupt line.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And queued on at91-4.5-dt.

Thanks! Bye,

> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index e683856c507c..75341eec2dfd 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -308,6 +308,7 @@
>  
>  				pinctrl_macb0_phy_irq: macb0_phy_irq {
>  					pinmux = <PIN_PC9__GPIO>;
> +					bias-disable;
>  				};
>  
>  				pinctrl_pdmic_default: pdmic_default {
> 


-- 
Nicolas Ferre
