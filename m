From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 11 Aug 2017 17:18:26 -0500
Subject: [PATCH 4/4] ARM: dts: keystone-k2g: Add I2C nodes
In-Reply-To: <20170802221753.13786-5-fcooper@ti.com>
References: <20170802221753.13786-1-fcooper@ti.com>
 <20170802221753.13786-5-fcooper@ti.com>
Message-ID: <69c0a96c-6bf8-984a-d029-d46bdf678284@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/02/2017 05:17 PM, Franklin S Cooper Jr wrote:
> From: Vitaly Andrianov <vitalya@ti.com>
> 
> Add nodes for the various I2C instances.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> [d-gerlach at ti.com: Add power domain and clock properties]
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> [fcooper at ti.com: Update subject and commit message]
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

It might be better to send this patch separately as it will
go to the different tree.

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

> ---
>   arch/arm/boot/dts/keystone-k2g.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
> index bf4d1fa..5c0acf37 100644
> --- a/arch/arm/boot/dts/keystone-k2g.dtsi
> +++ b/arch/arm/boot/dts/keystone-k2g.dtsi
> @@ -27,6 +27,9 @@
>   
>   	aliases {
>   		serial0 = &uart0;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
>   	};
>   
>   	cpus {
> @@ -113,6 +116,39 @@
>   			status = "disabled";
>   		};
>   
> +		i2c0: i2c at 2530000 {
> +			compatible = "ti,keystone-i2c";
> +			reg = <0x02530000 0x400>;
> +			clocks = <&k2g_clks 0x003a 0>;
> +			power-domains = <&k2g_pds 0x003a>;
> +			interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c at 2530400 {
> +			compatible = "ti,keystone-i2c";
> +			reg = <0x02530400 0x400>;
> +			clocks = <&k2g_clks 0x003b 0>;
> +			power-domains = <&k2g_pds 0x003b>;
> +			interrupts = <GIC_SPI 89 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c at 2530800 {
> +			compatible = "ti,keystone-i2c";
> +			reg = <0x02530800 0x400>;
> +			clocks = <&k2g_clks 0x003c 0>;
> +			power-domains = <&k2g_pds 0x003c>;
> +			interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>   		kirq0: keystone_irq at 026202a0 {
>   			compatible = "ti,keystone-irq";
>   			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>;
> 

-- 
regards,
-grygorii
