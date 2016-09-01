From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 01 Sep 2016 13:21:42 +0200
Subject: [PATCH 2/2] ARM: dts: exynos: Fix mismatched values of SD drive
 strengh configuration on exynos4415
In-Reply-To: <1472719022-27226-2-git-send-email-k.kozlowski@samsung.com>
References: <1472719022-27226-1-git-send-email-k.kozlowski@samsung.com>
 <1472719022-27226-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <3122615.TmPyqONA3V@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Thursday, September 01, 2016 10:37:02 AM Krzysztof Kozlowski wrote:
> The pinctrl drive strength register on exynos4415 is 2-bit wide for each
> pin.  The pins for SD2 were configured with value of 4.  The driver does
> not validate the value so this overflow effectively set a bit 1 in
> adjacent pins thus configuring them to drive strength 2x.
> 
> The author's intention was probably to set drive strength of 4x.
> All other SD pins are configured with drive strength of 4x.  Fix these
> with same pattern.
> 
> Fixes: 9246e7ff24c5 ("ARM: dts: Add dts files for exynos4415 SoC")
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

BTW This reminds me that there are still no board files for Exynos4415
SoC based boards so maybe we should consider removal of its support?

> ---
>  arch/arm/boot/dts/exynos4415-pinctrl.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
> index f54aee53b6ec..76cfd872ead3 100644
> --- a/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos4415-pinctrl.dtsi
> @@ -480,14 +480,14 @@
>  		samsung,pins = "gpk2-0";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>  		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> -		samsung,pin-drv = <4>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>  	};
>  
>  	sd2_cmd: sd2-cmd {
>  		samsung,pins = "gpk2-1";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>  		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> -		samsung,pin-drv = <4>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>  	};
>  
>  	sd2_cd: sd2-cd {
> @@ -501,14 +501,14 @@
>  		samsung,pins = "gpk2-3";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>  		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> -		samsung,pin-drv = <4>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>  	};
>  
>  	sd2_bus4: sd2-bus-width4 {
>  		samsung,pins = "gpk2-4", "gpk2-5", "gpk2-6";
>  		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
>  		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
> -		samsung,pin-drv = <4>;
> +		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
>  	};
>  
>  	cam_port_b_io: cam-port-b-io {

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
