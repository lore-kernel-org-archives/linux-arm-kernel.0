From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 16:43:25 +0800
Subject: [PATCH] ARM: dts: add sram for imx53 and imx6q
In-Reply-To: <1372416798-2828-1-git-send-email-p.zabel@pengutronix.de>
References: <1372416798-2828-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130701084323.GC13206@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 12:53:18PM +0200, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx53.dtsi   | 5 +++++
>  arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index d437bfb..3def46f 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -1087,5 +1087,10 @@
>  				status = "disabled";
>  			};
>  		};
> +
> +		ocram: ocram at f8000000 {
> +			compatible = "fsl,imx-ocram", "mmio-sram";

I think we agreed to drop this custom compatible "fsl,imx-ocram" for
now [1]?

Shawn

[1] http://thread.gmane.org/gmane.linux.kernel/1460369/focus=1465840

> +			reg = <0xf8000000 0x20000>;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 2d73f83..e1fe8a4 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -100,6 +100,12 @@
>  			status = "disabled";
>  		};
>  
> +		ocram: ocram at 00900000 {
> +			compatible = "fsl,imx-ocram", "mmio-sram";
> +			reg = <0x00900000 0x3f000>;
> +			clocks = <&clks 142>;
> +		};
> +
>  		timer at 00a00600 {
>  			compatible = "arm,cortex-a9-twd-timer";
>  			reg = <0x00a00600 0x20>;
> -- 
> 1.8.3.1
> 
