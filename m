From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 12:33:54 +0200
Subject: [PATCH 03/23] ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
In-Reply-To: <20130626101816.GE27083@manwe>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
 <20130626101816.GE27083@manwe>
Message-ID: <20130626103354.GH27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:18:17PM +0200, Thierry Reding wrote:
> On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote:
> [...]
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
> referenced in the DTS files.

Scratch that. SWGID() yields a mask for the corresponding swgroup so
it's not the same thing.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/529d53c6/attachment-0001.sig>
