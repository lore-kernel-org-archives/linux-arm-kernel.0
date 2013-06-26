From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 12:52:17 +0200
Subject: [PATCH 06/23] ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
In-Reply-To: <1372238906-9346-7-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-7-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626105216.GL27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:09PM +0300, Hiroshi Doyu wrote:
> This is a bitmap that indicates which HardWare Accelerators(HWA) are
> supported on Tegra114 SoC.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra114.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> index 1f45cf5..715b5d6 100644
> --- a/arch/arm/boot/dts/tegra114.dtsi
> +++ b/arch/arm/boot/dts/tegra114.dtsi
> @@ -323,7 +323,7 @@
>  		       0x70019228 0x074>;
>  		nvidia,#asids = <4>;
>  		dma-window = <0 0x40000000>;
> -		nvidia,swgroups = <0x18659fe>;
> +		nvidia,swgroups = <0x00000000 0x01b659fe>;
>  		nvidia,ahb = <&ahb>;
>  	};

It seems like an nvidia,tegra114-smmu.txt file is missing from the
Documentation/devicetree/bindings/iommu directory. And similarily to my
comment for the tegra30.dtsi update this could be a symbolic value such
as TEGRA114_SWGID_ALL.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/fdd17edb/attachment-0001.sig>
