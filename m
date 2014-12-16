From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Dec 2014 17:04:43 +0800
Subject: [PATCH v2] ARM: i.MX53: dts: add sahara module
In-Reply-To: <1418115412-20691-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1418115412-20691-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20141216090442.GJ2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 09, 2014 at 09:56:52AM +0100, Steffen Trumtrar wrote:
> The i.MX53 has a SAHARA v4 core. Add it to the dtsi.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
> Changes since v1:
> 	- remove status property
> 
>  arch/arm/boot/dts/imx53.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index b96213ba0671..ff4fa7ecacd8 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -765,6 +765,15 @@
>  				resets = <&src 1>;
>  				iram = <&ocram>;
>  			};
> +
> +			sahara: crypto at 63ff8000 {
> +				compatible = "fsl,imx53-sahara";

Is there already a driver for it in the kernel?

Shawn

> +				reg = <0x63ff8000 0x4000>;
> +				interrupts = <19 20>;
> +				clocks = <&clks IMX5_CLK_SAHARA_IPG_GATE>,
> +				         <&clks IMX5_CLK_SAHARA_IPG_GATE>;
> +				clock-names = "ipg", "ahb";
> +			};
>  		};
>  
>  		ocram: sram at f8000000 {
> -- 
> 2.1.3
> 
