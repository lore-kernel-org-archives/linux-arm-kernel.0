From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 10 Jun 2014 14:27:30 +0200
Subject: [PATCH v2 4/5] ARM: atmel: sama5d3xek: switch sound to CCF
In-Reply-To: <1402284707-23354-5-git-send-email-voice.shen@atmel.com>
References: <1402284707-23354-1-git-send-email-voice.shen@atmel.com>
 <1402284707-23354-5-git-send-email-voice.shen@atmel.com>
Message-ID: <5396F9B2.9010106@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2014 05:31, Bo Shen :
> As the sama5d3xek board has switch to CCF, so add clock for wm8904
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> Reviwed-by: Mark Brown <broonie@linaro.org>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And taken for next "dt" branch (maybe can go in before). Thanks.

> ---
> Changes in v2:
>   - None
> 
>  arch/arm/boot/dts/sama5d3xmb.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
> index 306eef0..b8c6f20 100644
> --- a/arch/arm/boot/dts/sama5d3xmb.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
> @@ -45,6 +45,8 @@
>  				wm8904: wm8904 at 1a {
>  					compatible = "wm8904";
>  					reg = <0x1a>;
> +					clocks = <&pck0>;
> +					clock-names = "mclk";
>  				};
>  			};
>  
> 


-- 
Nicolas Ferre
