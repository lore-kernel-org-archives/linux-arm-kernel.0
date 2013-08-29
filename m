From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 29 Aug 2013 20:42:18 +0800
Subject: [PATCH v3 resend 1/2] ARM:dts: vf610: Add DSPI nodes
In-Reply-To: <1377673724-32468-1-git-send-email-b44548@freescale.com>
References: <1377673724-32468-1-git-send-email-b44548@freescale.com>
Message-ID: <20130829124216.GH18729@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 03:08:43PM +0800, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> Add Freescale DSPI node into vf610 dts.
> 
> Signed-off-by: Chao Fu <b44548@freescale.com>
> ---
>  arch/arm/boot/dts/vf610.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index 67d929c..af687a4 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -87,6 +87,18 @@
>  				arm,tag-latency = <2 2 2>;
>  			};
>  
> +			dspi0: dspi0 at 4002c000 {

The node should be sorted in address.  That said, it should be put after
uart3.

Shawn

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,vf610-dspi";
> +				reg = <0x4002c000 0x1000>;
> +				interrupts = <0 67 0x04>;
> +				clocks = <&clks VF610_CLK_DSPI0>;
> +				clock-names = "dspi";
> +				spi-num-chipselects = <5>;
> +				status = "disabled";
> +			};
> +
>  			uart0: serial at 40027000 {
>  				compatible = "fsl,vf610-lpuart";
>  				reg = <0x40027000 0x1000>;
> -- 
> 1.8.0
> 
> 
