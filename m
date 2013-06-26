From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Wed, 26 Jun 2013 13:02:27 +0200
Subject: [PATCH 03/23] ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
In-Reply-To: <20130626101816.GE27083@manwe>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com><20130626101816.GE27083@manwe>
Message-ID: <20130626.140227.471410226520470110.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> wrote @ Wed, 26 Jun 2013 12:18:17 +0200:

> > diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
> [...]
> > @@ -23,3 +24,13 @@ Example:
> >  		nvidia,swgroups = <0x00000000 0x000779ff>;
> >  		nvidia,ahb = <&ahb>;
> >  	};
> > +
> > +	host1x {
> > +		compatible = "nvidia,tegra30-host1x", "simple-bus";
> > +		nvidia,memory-clients = <SWGID_HC>;
> 
> And this could use the SWGID(HC) to match up with how GPIOs are
> referenced in the DTS files. Though I see that the clocks don't use a
> parameterized version either, so things are inconsistent anyway. But if
> SWGID() isn't used then maybe it shouldn't be provided by the header
> file in the first place.

I think that the above SWGID_* is still easier to understand which
swgroup a device belongs to rather than raw number intuitively.

> Oh, one other thing: both GPIO and CAR use the TEGRA_ prefix, perhaps
> this should use it as well?

Sounds quite reasonable to me.
