From: stefan@agner.ch (Stefan Agner)
Date: Fri, 03 Jul 2015 14:57:45 +0200
Subject: [PATCH v1 1/4] ARM: dts: vfxxx: Add io-channel-cells property for
 ADC node
In-Reply-To: <916569b56d60d41f9cd12c5244be3778857a971b.1435646447.git.maitysanchayan@gmail.com>
References: <cover.1435646447.git.maitysanchayan@gmail.com>
 <916569b56d60d41f9cd12c5244be3778857a971b.1435646447.git.maitysanchayan@gmail.com>
Message-ID: <101a8c84fbe2063f6cf56737a5f9417f@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-06-30 08:54, Sanchayan Maity wrote:
> This commit adds io-channel-cells property to the ADC node. This
> property is required in order for an IIO consumer driver to work.
> Especially required for Colibri VF50, as the touchscreen driver
> uses ADC channels with the ADC driver based on IIO framework.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 2c20f3f..f7d8fb6 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -227,6 +227,7 @@
>  				clocks = <&clks VF610_CLK_ADC0>;
>  				clock-names = "adc";
>  				status = "disabled";
> +				#io-channel-cells = <1>;
>  			};
>  
>  			tcon0: tcon at 4003d000 {
> @@ -461,6 +462,7 @@
>  				clocks = <&clks VF610_CLK_ADC1>;
>  				clock-names = "adc";
>  				status = "disabled";
> +				#io-channel-cells = <1>;
>  			};
>  
>  			esdhc1: esdhc at 400b2000 {

Minor nitpick: can you put the new property one line up? That way it
would be sorted alphabetically and status is conveniently still at the
end.

Otherwise:

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan
