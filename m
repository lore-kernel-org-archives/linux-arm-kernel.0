From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Dec 2014 17:11:53 +0800
Subject: [PATCH] ARM: dts: imx6qdl: Remove OCRAM clock from VPU node
In-Reply-To: <1418300292-26019-1-git-send-email-fabio.estevam@freescale.com>
References: <1418300292-26019-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20141216091151.GK2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 10:18:12AM -0200, Fabio Estevam wrote:
> According to Documentation/devicetree/bindings/media/coda.txt:
> 
> - clock-names : Should be "ahb", "per"
> 
> The OCRAM clock is already provided inside the ocram node, so remove the OCRAM 
> clock from the VPU node.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

It doesn't apply to my imx/dt branch.

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index f821999..2409d1f 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -339,9 +339,8 @@
>  				             <0 3 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "bit", "jpeg";
>  				clocks = <&clks IMX6QDL_CLK_VPU_AXI>,
> -					 <&clks IMX6QDL_CLK_MMDC_CH0_AXI>,
> -					 <&clks IMX6QDL_CLK_OCRAM>;
> -				clock-names = "per", "ahb", "ocram";
> +					 <&clks IMX6QDL_CLK_MMDC_CH0_AXI>;
> +				clock-names = "per", "ahb";
>  				resets = <&src 1>;
>  				iram = <&ocram>;
>  			};
> -- 
> 1.9.1
> 
