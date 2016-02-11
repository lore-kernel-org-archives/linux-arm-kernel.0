From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 11 Feb 2016 02:41:28 +0200
Subject: [PATCH v3 7/8] ARM: dts: r8a7790: add iommus to dmac0 and dmac1
In-Reply-To: <1455065878-11906-8-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455065878-11906-8-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <1704813.5Ff44u3Kaz@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

Thank you for the patch.

On Wednesday 10 February 2016 01:57:57 Niklas S?derlund wrote:

No commit message ? I'd at least mention that as a side effect of this patch 
channel 0 and 15 are disabled, reducing the effective number of channels to 14 
per DMAC.

> Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Same comment and ack for patch 8/8.

Note that we should still try to find a way to selectively enable the IOMMU in 
a per-device fashion, as system integrators might want it to be disabled for 
some devices. There's no urgency though.

> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 7dfd393..048bbf8 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -294,6 +294,21 @@
>  		power-domains = <&cpg_clocks>;
>  		#dma-cells = <1>;
>  		dma-channels = <15>;
> +		iommus = <&ipmmu_ds 0>,
> +			 <&ipmmu_ds 1>,
> +			 <&ipmmu_ds 2>,
> +			 <&ipmmu_ds 3>,
> +			 <&ipmmu_ds 4>,
> +			 <&ipmmu_ds 5>,
> +			 <&ipmmu_ds 6>,
> +			 <&ipmmu_ds 7>,
> +			 <&ipmmu_ds 8>,
> +			 <&ipmmu_ds 9>,
> +			 <&ipmmu_ds 10>,
> +			 <&ipmmu_ds 11>,
> +			 <&ipmmu_ds 12>,
> +			 <&ipmmu_ds 13>,
> +			 <&ipmmu_ds 14>;
>  	};
> 
>  	dmac1: dma-controller at e6720000 {
> @@ -325,6 +340,21 @@
>  		power-domains = <&cpg_clocks>;
>  		#dma-cells = <1>;
>  		dma-channels = <15>;
> +		iommus = <&ipmmu_ds 15>,
> +			 <&ipmmu_ds 16>,
> +			 <&ipmmu_ds 17>,
> +			 <&ipmmu_ds 18>,
> +			 <&ipmmu_ds 19>,
> +			 <&ipmmu_ds 20>,
> +			 <&ipmmu_ds 21>,
> +			 <&ipmmu_ds 22>,
> +			 <&ipmmu_ds 23>,
> +			 <&ipmmu_ds 24>,
> +			 <&ipmmu_ds 25>,
> +			 <&ipmmu_ds 26>,
> +			 <&ipmmu_ds 27>,
> +			 <&ipmmu_ds 28>,
> +			 <&ipmmu_ds 29>;
>  	};
> 
>  	audma0: dma-controller at ec700000 {

-- 
Regards,

Laurent Pinchart
