From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Oct 2014 00:33:41 +0200
Subject: [PATCH v3 3/3] ARM: dts: rk3288: add VOP iommu nodes
In-Reply-To: <1412965848-18663-4-git-send-email-djkurtz@chromium.org>
References: <1412965848-18663-1-git-send-email-djkurtz@chromium.org>
 <1412965848-18663-4-git-send-email-djkurtz@chromium.org>
Message-ID: <4094180.e6s5oT6HgP@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Am Samstag, 11. Oktober 2014, 02:30:48 schrieb Daniel Kurtz:
> Add device nodes for the VOP iommus.
> Device nodes for other iommus will be added in later patches.
> 
> The iommu nodes use the #iommu-cells property as described in:
>   Documentation/devicetree/bindings/iommu/iommu.txt
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 5950b0a..cbc92fa 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -271,6 +271,24 @@
>  		status = "disabled";
>  	};
> 
> +	vopb_mmu: iommu at 0xff930300 {

please use the address without the 0x here ... iommu at ff930300


Thanks
Heiko

> +		compatible = "rockchip,iommu";
> +		reg = <0xff930300 0x100>;
> +		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "vopb_mmu";
> +		#iommu-cells = <0>;
> +		status = "disabled";
> +	};
> +
> +	vopl_mmu: iommu at 0xff940300 {
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
