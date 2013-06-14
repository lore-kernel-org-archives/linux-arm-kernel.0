From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 14 Jun 2013 14:17:23 +0800
Subject: [PATCH 5/9] ARM: dtsi: imx6qdl-sabresd: add a fixed regulator
 for WM8962
In-Reply-To: <94d5c03e0603aa359c07e13a684bffdbaad7db3d.1371123426.git.b42378@freescale.com>
References: <cover.1371123426.git.b42378@freescale.com>
 <94d5c03e0603aa359c07e13a684bffdbaad7db3d.1371123426.git.b42378@freescale.com>
Message-ID: <20130614061722.GB20513@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 07:51:00PM +0800, Nicolin Chen wrote:
> On Sabre SD, system controls WM8962 power by pulling up/down GPIO_4_10,
> so add a regulator controled by GPIO_4_10 for WM8962.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index e21f6a8..13af158 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -26,6 +26,13 @@
>  			gpio = <&gpio3 22 0>;
>  			enable-active-high;
>  		};
> +
> +		reg_audio: 8962_supply {

8962 does not looks like a good name.  I changed it to wm8962.

> +			compatible = "regulator-fixed";
> +			regulator-name = "8962-SUPPLY";

We generally use lowercases in device tree, so I changed it to
"wm8962-supply".

Shawn

> +			gpio = <&gpio4 10 0>;
> +			enable-active-high;
> +		};
>  	};
>  
>  	gpio-keys {
> -- 
> 1.7.1
> 
> 
