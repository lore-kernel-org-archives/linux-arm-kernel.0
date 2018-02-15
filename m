From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 15 Feb 2018 12:55:35 +0100
Subject: [PATCH] ARM64: dts: meson-axg: add sec_AO system controller
In-Reply-To: <20180215101207.19186-1-jbrunet@baylibre.com>
References: <20180215101207.19186-1-jbrunet@baylibre.com>
Message-ID: <412132e7-904d-61c4-d09f-0239e07a92be@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/2018 11:12, Jerome Brunet wrote:
> add the secure AO system controller with chipid enabled
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 880e25b113c1..7f4c00216b82 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -836,6 +836,12 @@
>  				};
>  			};
>  
> +			sec_AO: ao-secure at 140 {
> +				compatible = "amlogic,meson-gx-ao-secure", "syscon";
> +				reg = <0x0 0x140 0x0 0x140>;
> +				amlogic,has-chip-id;
> +			};
> +
>  			pwm_AO_ab: pwm at 7000 {
>  				compatible = "amlogic,meson-axg-ao-pwm";
>  				reg = <0x0 0x07000 0x0 0x20>;
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
