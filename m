From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 27 May 2013 16:30:35 +0800
Subject: [PATCH] ARM: mx6: Use the same sdma firmware name for all mx6
 variants
In-Reply-To: <1369504048-19805-1-git-send-email-festevam@gmail.com>
References: <1369504048-19805-1-git-send-email-festevam@gmail.com>
Message-ID: <20130527083034.GB19397@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 25, 2013 at 02:47:28PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> All the mx6 variants (quad, dual, solo and solo-lite) use the same sdma 
> firmware, so drop the the suffix from the file name.

But you do not know if the next imx6 variant uses the same sdma
firmware.

The suffix should be taken as a compatible/version mark, and it should
be fine to use sdma-imx6q.bin on any other SoCs that use the same
firmware.

Shawn

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
>  arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 42e461c..b6730cc 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -582,7 +582,7 @@
>  				interrupts = <0 2 0x04>;
>  				clocks = <&clks 155>, <&clks 155>;
>  				clock-names = "ipg", "ahb";
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6q.bin";
> +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6.bin";
>  			};
>  		};
>  
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index c5e5da0..9596000 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -594,7 +594,7 @@
>  				clocks = <&clks IMX6SL_CLK_SDMA>,
>  					 <&clks IMX6SL_CLK_SDMA>;
>  				clock-names = "ipg", "ahb";
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6sl.bin";
> +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx6.bin";
>  			};
>  
>  			pxp: pxp at 020f0000 {
> -- 
> 1.8.1.2
> 
