From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Wed, 6 Sep 2017 08:41:16 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2 Xplained: Describe the SD card
 power supply
In-Reply-To: <20170905101805.15127-1-romain.izard.pro@gmail.com>
References: <20170905101805.15127-1-romain.izard.pro@gmail.com>
Message-ID: <20170906064116.kr4rbq6o5jly7oo5@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 12:18:05PM +0200, Romain Izard wrote:
> As the SAMA5D2 SDHCI controller works with an external power supply,
> describe the power supply for the SD card slot. This makes it possible
> to use mmc power sequences, in the case of external SDIO modules.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 2e2c3d1a1fa2..e0b0292ef132 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -103,6 +103,8 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_sdmmc1_default>;
>  			status = "okay"; /* conflict with qspi0 */
> +			vqmmc-supply = <&vdd_3v3_reg>;
> +			vmmc-supply = <&vdd_3v3_reg>;
>  		};
>  
>  		apb {
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
