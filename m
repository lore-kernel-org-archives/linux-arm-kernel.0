From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 15 Feb 2018 12:55:19 +0100
Subject: [PATCH] ARM64: dts: meson-axg: fix pwm_AO_cd compatible
In-Reply-To: <20180215101031.18934-1-jbrunet@baylibre.com>
References: <20180215101031.18934-1-jbrunet@baylibre.com>
Message-ID: <9a161f47-3e4a-d1ed-f829-d6989191583a@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/2018 11:10, Jerome Brunet wrote:
> The compatible in pwm_AO_cd is wrong and does not match anything.
> Correct this with the correct compatible string
> 
> Fixes: 4a81e5ddfb43 ("ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index a7cc9e401a92..880e25b113c1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -844,7 +844,7 @@
>  			};
>  
>  			pwm_AO_cd: pwm at 2000 {
> -				compatible = "amlogic,axg-ao-pwm";
> +				compatible = "amlogic,meson-axg-ao-pwm";
>  				reg = <0x0 0x02000  0x0 0x20>;
>  				#pwm-cells = <3>;
>  				status = "disabled";
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
