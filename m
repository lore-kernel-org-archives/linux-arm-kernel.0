From: anilkumar.v@ti.com (Kumar, Anil)
Date: Wed, 6 Mar 2013 04:19:58 +0000
Subject: [PATCH v8 6/9] ARM: dts: add AM33XX EDMA support
In-Reply-To: <1362516795-6346-7-git-send-email-mporter@ti.com>
References: <1362516795-6346-1-git-send-email-mporter@ti.com>
 <1362516795-6346-7-git-send-email-mporter@ti.com>
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412CD652@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 06, 2013 at 02:23:12, Porter, Matt wrote:
> Adds AM33XX EDMA support to the am33xx.dtsi as documented in
> Documentation/devicetree/bindings/dma/ti-edma.txt
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 0957645..aaf44122 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -87,6 +87,26 @@
>  			reg = <0x48200000 0x1000>;
>  		};
>  
> +		edma: edma at 49000000 {
> +			compatible = "ti,edma3";
> +			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> +			reg =	<0x49000000 0x10000>,
> +				<0x44e10f90 0x10>;
> +			interrupt-parent = <&intc>;

Is it really need of "interrupt-parent = <&intc>" here ?
as this property is already with root node.  
I am taking reference of 3.9-rc1

Thanks,
Anil

> +			interrupts = <12 13 14>;
> +			#dma-cells = <1>;
> +			dma-channels = <64>;
> +			ti,edma-regions = <4>;
> +			ti,edma-slots = <256>;
> +			ti,edma-queue-tc-map = <0 0
> +						1 1
> +						2 2>;
> +			ti,edma-queue-priority-map = <0 0
> +						      1 1
> +						      2 2>;
> +			ti,edma-default-queue = <0>;
> +		};
> +
>  		gpio1: gpio at 44e07000 {
>  			compatible = "ti,omap4-gpio";
>  			ti,hwmods = "gpio1";
> -- 
> 1.7.9.5
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
