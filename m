From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Wed, 2 May 2018 09:14:18 +0000
Subject: [PATCH v4 6/6] arm64: dts: ls208xa: comply with the iommu map
 binding for fsl_mc
In-Reply-To: <1525069641-8523-7-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-7-git-send-email-nipun.gupta@nxp.com>
Message-ID: <5AE98169.7060102@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nipun,

On 04/30/2018 09:27 AM, Nipun Gupta wrote:
> fsl-mc bus support the new iommu-map property. Comply to this binding
> for fsl_mc bus.
>
> Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>

This looks good to me, so:

Reviewed-By: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

> ---
>   arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 137ef4d..6010505 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -184,6 +184,7 @@
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges;
> +		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
>
>   		clockgen: clocking at 1300000 {
>   			compatible = "fsl,ls2080a-clockgen";
> @@ -357,6 +358,8 @@
>   			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
>   			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
>   			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
> +			dma-coherent;
>   			#address-cells = <3>;
>   			#size-cells = <1>;
>
> @@ -460,6 +463,8 @@
>   			compatible = "arm,mmu-500";
>   			reg = <0 0x5000000 0 0x800000>;
>   			#global-interrupts = <12>;
> +			#iommu-cells = <1>;
> +			stream-match-mask = <0x7C00>;
>   			interrupts = <0 13 4>, /* global secure fault */
>   				     <0 14 4>, /* combined secure interrupt */
>   				     <0 15 4>, /* global non-secure fault */
> @@ -502,7 +507,6 @@
>   				     <0 204 4>, <0 205 4>,
>   				     <0 206 4>, <0 207 4>,
>   				     <0 208 4>, <0 209 4>;
> -			mmu-masters = <&fsl_mc 0x300 0>;
>   		};
>
>   		dspi: dspi at 2100000 {
>
