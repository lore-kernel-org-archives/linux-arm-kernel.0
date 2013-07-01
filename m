From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Mon, 1 Jul 2013 10:24:46 +0200
Subject: [PATCH 06/23] ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
In-Reply-To: <20130626105216.GL27083@manwe>
References: <1372238906-9346-7-git-send-email-hdoyu@nvidia.com><20130626105216.GL27083@manwe>
Message-ID: <20130701.112446.119298599375396428.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> wrote @ Wed, 26 Jun 2013 12:52:17 +0200:

> * PGP Signed by an unknown key
> 
> On Wed, Jun 26, 2013 at 12:28:09PM +0300, Hiroshi Doyu wrote:
> > This is a bitmap that indicates which HardWare Accelerators(HWA) are
> > supported on Tegra114 SoC.
> > 
> > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> > ---
> >  arch/arm/boot/dts/tegra114.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
> > index 1f45cf5..715b5d6 100644
> > --- a/arch/arm/boot/dts/tegra114.dtsi
> > +++ b/arch/arm/boot/dts/tegra114.dtsi
> > @@ -323,7 +323,7 @@
> >  		       0x70019228 0x074>;
> >  		nvidia,#asids = <4>;
> >  		dma-window = <0 0x40000000>;
> > -		nvidia,swgroups = <0x18659fe>;
> > +		nvidia,swgroups = <0x00000000 0x01b659fe>;
> >  		nvidia,ahb = <&ahb>;
> >  	};
> 
> It seems like an nvidia,tegra114-smmu.txt file is missing from the
> Documentation/devicetree/bindings/iommu directory.

All difference between T30 and T114 is now provided from DT. They have
all same entries but only those values are different.

Do we still need a copy of nvidia,tegra30-smmu.txt for t114 or is just
tweaking nvidia,tegra30-smmu.txt for t114 enough?
