From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Apr 2014 14:16:12 +0800
Subject: [PATCH] ARM: dts: imx6qdl: Add VDOA compatible and clocks
 properties
In-Reply-To: <1397499525-6478-1-git-send-email-philipp.zabel@gmail.com>
References: <1397499525-6478-1-git-send-email-philipp.zabel@gmail.com>
Message-ID: <20140416061610.GF2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 08:18:45PM +0200, Philipp Zabel wrote:
> This adds a compatible property and the correct clock for the
> i.MX6Q Video Data Order Adapter.
> 
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index c05a501..8aea954 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -976,8 +976,10 @@
>  			};
>  
>  			vdoa at 021e4000 {
> +				compatible = "fsl,imx6q-vdoa";

I would like to see this to be documented in
Documentation/devicetree/bindings/ first.

Shawn

>  				reg = <0x021e4000 0x4000>;
>  				interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks 202>;
>  			};
>  
>  			uart2: serial at 021e8000 {
> -- 
> 1.9.1
> 
> 
> 
