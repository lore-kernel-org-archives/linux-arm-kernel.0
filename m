From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 9 Oct 2016 09:34:52 +0100
Subject: [PATCH v3 3/4] ARM: dts: am33xx: add DMA properties for tscadc
In-Reply-To: <20161005090443.24576-4-mugunthanvnm@ti.com>
References: <20161005090443.24576-1-mugunthanvnm@ti.com>
 <20161005090443.24576-4-mugunthanvnm@ti.com>
Message-ID: <b8272b0e-3051-445b-865e-968d2dac1a9f@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/16 10:04, Mugunthan V N wrote:
> Add DMA properties for tscadc
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
Do the binding docs need updating to reflect this?  I can't immediately
find the relevant doc to check!

Jonathan
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 98748c6..6d607b8 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -917,6 +917,8 @@
>  			interrupts = <16>;
>  			ti,hwmods = "adc_tsc";
>  			status = "disabled";
> +			dmas = <&edma 53 0>, <&edma 57 0>;
> +			dma-names = "fifo0", "fifo1";
>  
>  			tsc {
>  				compatible = "ti,am3359-tsc";
> 
