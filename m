From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Thu, 19 Feb 2015 11:29:52 -0600
Subject: [PATCH] ARM: socfpga: fix uart DMA binding error
In-Reply-To: <1424347672-25075-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1424347672-25075-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1502191118120.20048@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Feb 2015, Steffen Trumtrar wrote:

> socfpga.dtsi is missing the DMA channels for the uart nodes.
> This will produce the following errors:
> 
> 	of_dma_request_slave_channel: dma-names property of node '/soc/serial0 at ffc02000' missing or empty
> 	ttyS0 - failed to request DMA
> 
> Provide the correct DMA channels to fix this.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/socfpga.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 252c3d1bda50..9d8760956752 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -713,6 +713,9 @@
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			clocks = <&l4_sp_clk>;
> +			dmas = <&pdma 28>,
> +			       <&pdma 29>;
> +			dma-names = "tx", "rx";
>  		};
>  
>  		uart1: serial1 at ffc03000 {
> @@ -722,6 +725,9 @@
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			clocks = <&l4_sp_clk>;
> +			dmas = <&pdma 30>,
> +			       <&pdma 31>;
> +			dma-names = "tx", "rx";
>  		};
>  
>  		rst: rstmgr at ffd05000 {
> -- 
> 2.1.4
> 
> 

Applied to fixes.

BR,
Dinh
