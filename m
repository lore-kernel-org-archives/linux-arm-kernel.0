From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 Aug 2017 12:31:31 +0100
Subject: [PATCH v2] ARM64: dts: ls208xa: Add iommu-map property for pci
In-Reply-To: <1504171637-15670-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1504171637-15670-1-git-send-email-Bharat.Bhushan@nxp.com>
Message-ID: <20170831113131.GG15031@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 02:57:17PM +0530, Bharat Bhushan wrote:
> This patch adds iommu-map property for PCIe, which enables
> SMMU for these devices on LS208xA devices.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
> v1->v2
>  - Corrected "RM64" to "ARM64"

Please let's settle the ongoing discussion on v1 before sending new
versions of this.

Mark.

> 
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 94cdd30..67cf605 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -606,6 +606,7 @@
>  			num-lanes = <4>;
>  			bus-range = <0x0 0xff>;
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>;	/* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 0 109 4>,
> @@ -627,6 +628,7 @@
>  			num-lanes = <4>;
>  			bus-range = <0x0 0xff>;
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>;	/* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 0 114 4>,
> @@ -648,6 +650,7 @@
>  			num-lanes = <8>;
>  			bus-range = <0x0 0xff>;
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>;	/* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 0 119 4>,
> @@ -669,6 +672,7 @@
>  			num-lanes = <4>;
>  			bus-range = <0x0 0xff>;
>  			msi-parent = <&its>;
> +			iommu-map = <0 &smmu 0 1>;	/* This is fixed-up by u-boot */
>  			#interrupt-cells = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0000 0 0 1 &gic 0 0 0 124 4>,
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
