From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 2 Dec 2015 11:07:15 +0100
Subject: [PATCH] ARM: at91/dt: add always-on to 1.8V regulator
In-Reply-To: <1449050800-29284-1-git-send-email-nicolas.ferre@atmel.com>
References: <1449050800-29284-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20151202100715.GB5049@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 11:06:40AM +0100, Nicolas Ferre wrote:
> As the SDHCI controller needs the 1.8V line to be always enabled for some eMMC
> configurations, set the proper "regulator-always-on" property to the board DTS
> files.
> Note that the sdhci classical regulator definitions doesn't suit our controller
> for this 1.8V purpose.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index ad6de73ed5a5..e74df327cdd3 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -184,6 +184,7 @@
>  							regulator-name = "VDD_SDHC_1V8";
>  							regulator-min-microvolt = <1800000>;
>  							regulator-max-microvolt = <1800000>;
> +							regulator-always-on;
>  						};
>  					};
>  				};
> -- 
> 2.1.3
> 
