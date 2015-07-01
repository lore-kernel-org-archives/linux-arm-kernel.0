From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Jul 2015 13:41:01 +0100
Subject: [PATCH] keystone: dts: add psci command definition
In-Reply-To: <1435752784-30639-2-git-send-email-vitalya@ti.com>
References: <1435752784-30639-1-git-send-email-vitalya@ti.com>
 <1435752784-30639-2-git-send-email-vitalya@ti.com>
Message-ID: <20150701124101.GB2310@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 01:13:04PM +0100, Vitaly Andrianov wrote:
> This commit adds definition for cpu_on, cpu_off and cpu_suspend commands.
> These definitions must match the corresponding PSCI definitions in
> boot monitor.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> ---
>  arch/arm/boot/dts/keystone.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index c06542b..ab60fca 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -58,6 +58,14 @@
>  			     <GIC_SPI 23 IRQ_TYPE_EDGE_RISING>;
>  	};
>  
> +	psci {
> +		compatible	= "arm,psci";
> +		method		= "smc";
> +		cpu_suspend	= <0x84000001>;
> +		cpu_off		= <0x84000002>;
> +		cpu_on		= <0x84000003>;
> +	};

It would be nice to have this injected automatically by the bootlaoder
when PSCI is present, as that way users of existing systems can upgrade
their DTB and still have things boot.

Thanks,
Mark.

> +
>  	soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 1.9.1
> 
