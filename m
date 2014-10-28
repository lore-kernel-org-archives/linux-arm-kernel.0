From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 28 Oct 2014 15:37:52 +0100
Subject: [PATCH v6 3/3] ARM: dts: rk3288: add VOP iommu nodes
In-Reply-To: <1414413448-15819-4-git-send-email-djkurtz@chromium.org>
References: <1414413448-15819-1-git-send-email-djkurtz@chromium.org>
 <1414413448-15819-4-git-send-email-djkurtz@chromium.org>
Message-ID: <6644033.fY7Wj4BQVl@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 27. Oktober 2014, 20:37:28 schrieb Daniel Kurtz:
> Add device nodes for the VOP iommus.
> Device nodes for other iommus will be added in later patches.
> 
> The iommu nodes use the #iommu-cells property as described in:
>   Documentation/devicetree/bindings/iommu/iommu.txt
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>

Looks fine and I'll pick this patch up, once Joerg is statisfied with the iommu 
driver (patches 1 and 2).


Heiko

> ---
>  arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 5950b0a..df1170c 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -271,6 +271,24 @@
>  		status = "disabled";
>  	};
> 
> +	vopb_mmu: iommu at ff930300 {
> +		compatible = "rockchip,iommu";
> +		reg = <0xff930300 0x100>;
> +		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "vopb_mmu";
> +		#iommu-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	vopl_mmu: iommu at ff940300 {
> +		compatible = "rockchip,iommu";
> +		reg = <0xff940300 0x100>;
> +		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "vopl_mmu";
> +		#iommu-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	gic: interrupt-controller at ffc01000 {
>  		compatible = "arm,gic-400";
>  		interrupt-controller;
