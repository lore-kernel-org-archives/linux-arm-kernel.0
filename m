From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 12:24:29 +0200
Subject: [PATCH 02/23] ARM: dt: tegra30: iommu: Add "nvidia,swgroups"
In-Reply-To: <1372238906-9346-3-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626102428.GF27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:05PM +0300, Hiroshi Doyu wrote:
> This is a bitmap that indicates which HardWare Accelerators(HWA) are
> supported on Tegra30 SoC.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt | 6 +++++-
>  arch/arm/boot/dts/tegra30.dtsi                                  | 1 +
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> index 89fb543..6be51f6 100644
> --- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> @@ -8,14 +8,18 @@ Required properties:
>  - nvidia,#asids : # of ASIDs
>  - dma-window : IOVA start address and length.
>  - nvidia,ahb : phandle to the ahb bus connected to SMMU.
> +- nvidia,swgroups: A bit map of supported HardWare Accelerators(HWA).

Nit: you use the spelling "bitmap" in the subject but "bit map" here.
Both are correct but perhaps we should stick to one.

> +  Each bit represents one sgroup. The assignments may be found in header

Nit: "swgroup"

> -	smmu {
> +	iommu {

This change isn't really related, but given that the tegra30.dtsi
already uses it I guess we can keep it as part of this patch.

>  		compatible = "nvidia,tegra30-smmu";
>  		reg = <0x7000f010 0x02c
>  		       0x7000f1f0 0x010
>  		       0x7000f228 0x05c>;
>  		nvidia,#asids = <4>;		/* # of ASIDs */
>  		dma-window = <0 0x40000000>;	/* IOVA start & length */
> +		nvidia,swgroups = <0x00000000 0x000779ff>;

Perhaps this should be a symbolic name too? Perhaps something like
TEGRA30_SWGID_ALL?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/09d59650/attachment-0001.sig>
