From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 20 Feb 2017 11:20:04 +0100
Subject: [PATCH] ARM: at91/dt: Disable SPI on at91sam9x5ek to allow MCI1
 to work.
In-Reply-To: <1487265388-29390-1-git-send-email-cristian.birsan@microchip.com>
References: <1487265388-29390-1-git-send-email-cristian.birsan@microchip.com>
Message-ID: <95353208-6734-aec5-a41b-e62d28dd747c@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 16/02/2017 ? 18:16, cristian.birsan at microchip.com a ?crit :
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> The A13 hardware line is shared by SPI and MCI1 controller.This patch
> disables the SPI controller so that the MCI1 (the big MMC card slot) can
> be used.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  arch/arm/boot/dts/at91sam9x5ek.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> index 696b8ba..9d2bbc4 100644
> --- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> @@ -116,7 +116,7 @@
>  			};
>  
>  			spi0: spi at f0000000 {
> -				status = "okay";
> +				status = "disabled"; /* conflicts with mmc1 */
>  				cs-gpios = <&pioA 14 0>, <0>, <0>, <0>;
>  				m25p80 at 0 {
>  					compatible = "atmel,at25df321a";
> 


-- 
Nicolas Ferre
