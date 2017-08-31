From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 31 Aug 2017 10:32:09 +0100
Subject: [PATCH] RM64: dts: ls208xa: Add iommu-map property for pci
In-Reply-To: <1504171424-15536-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1504171424-15536-1-git-send-email-Bharat.Bhushan@nxp.com>
Message-ID: <06c57ca4-edaa-df26-b1d9-1906141c5065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/17 10:23, Bharat Bhushan wrote:
> This patch adds iommu-map property for PCIe, which enables
> SMMU for these devices on LS208xA devices.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
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

What does this do when your version of u-boot doesn't fill this in for you?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
