From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Feb 2014 09:08:30 +0000
Subject: [PATCH 1/3] Documentation:spi:fsl-dspi:add DSPI dma transfer
 support
In-Reply-To: <1393311258-14380-1-git-send-email-b44548@freescale.com>
References: <1393311258-14380-1-git-send-email-b44548@freescale.com>
Message-ID: <20140225090830.GO28555@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 06:54:16AM +0000, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> Add bool value use-dma.
> The bool will determine whether DSPI use dma channel transfer data
> in a platform.
> 
> Add dmas and dma-names for describing dma channels of DSPI.
> 
> Signed-off-by: Chao Fu      <b44548@freescale.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> index 5376de4..76a1039 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> @@ -11,6 +11,11 @@ Required properties:
>  - spi-num-chipselects : the number of the chipselect signals.
>  - bus-num : the slave chip chipselect signal number.
>  - big-endian : if DSPI modudle is big endian, the bool will be set in node.
> +- use-dma: the bool decide if use dma method in DSPI transfering.

Why can the OS not decide this based on the presence of dmas which it
can use?

Is there ever a case that there would be dmas present but it would be in
the interests of the OS to not use them?

Mark.

> +- dmas: List of DMA specifiers with the controller specific format
> +	as described in the generic DMA client binding. A tx and rx
> +	specifier is required for each chip select.
> +- dma-names: Should be named "tx" and "rx".
>  Example:
>  
>  dspi0 at 4002c000 {
> @@ -26,6 +31,10 @@ dspi0 at 4002c000 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_dspi0_1>;
>  	big-endian;
> +	use-dma;
> +	dmas = <&edma0 0 12>,
> +		<&edma0 0 13>;
> +	dma-names = "rx", "tx";
>  	status = "okay";
>  
>  	sflash: at26df081a at 0 {
> -- 
> 1.8.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
