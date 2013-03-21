From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 21 Mar 2013 16:13:20 +0100
Subject: [PATCH] DTS at91sam9x5ek: i2c1 and i2c2 conflict with macb and lcd
In-Reply-To: <1363778575-4809-1-git-send-email-richard.genoud@gmail.com>
References: <1363778575-4809-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130321151320.GB2490@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 12:22:54PM +0100, Richard Genoud wrote:
> on at91sam9x5ek, macb0 is enabled, so it conflicts with i2c2 (PB4)
> same for i2c1, (conflicts with LCD).
> Moreover, only i2c0 is used on this board.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
>  arch/arm/boot/dts/at91sam9x5ek.dtsi |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> index 8a7cf1d..1128565 100644
> --- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> @@ -61,14 +61,6 @@
>  				status = "okay";
>  			};
>  
> -			i2c1: i2c at f8014000 {
> -				status = "okay";
> -			};
> -
> -			i2c2: i2c at f8018000 {
> -				status = "okay";
> -			};
> -
>  			pinctrl at fffff400 {
>  				mmc0 {
>  					pinctrl_board_mmc0: mmc0-board {
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
