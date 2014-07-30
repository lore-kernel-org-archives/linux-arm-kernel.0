From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 30 Jul 2014 15:23:50 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <20140730110425.GI12239@arm.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140730110425.GI12239@arm.com>
Message-ID: <20140730132348.GM29590@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 30, 2014 at 12:04:25PM +0100, Will Deacon wrote:
> Hi all,
> 
> On Fri, Jul 04, 2014 at 04:29:17PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This commit introduces a generic device tree binding for IOMMU devices.
> > Only a very minimal subset is described here, but it is enough to cover
> > the requirements of both the Exynos System MMU and Tegra SMMU as
> > discussed here:
> > 
> >     https://lkml.org/lkml/2014/4/27/346
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v4:
> > - clarify that disabling an IOMMU DT node may not disable translation
> > - be more explicit that examples are only examples
> > - add multi-ID master example
> > 
> > Changes in v3:
> > - use #iommu-cells instead of #address-cells/#size-cells
> > - drop optional iommu-names property
> > 
> > Changes in v2:
> > - add notes about "dma-ranges" property (drop note from commit message)
> > - document priorities of "iommus" property vs. "dma-ranges" property
> > - drop #iommu-cells in favour of #address-cells and #size-cells
> > - remove multiple-master device example
> > 
> >  Documentation/devicetree/bindings/iommu/iommu.txt | 172 ++++++++++++++++++++++
> >  1 file changed, 172 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/iommu.txt
> 
> I'm concerned that this patch hasn't been picked up for 3.17 (I can't see it
> in -next). If we want to move the ARM SMMU driver over to this new binding,
> we can't keep dragging our feet for much longer as I *really* don't plan to
> support two bindings in parallel (one is complicated enough already).
> 
> Any chance we can see this merged, please?

I think there weren't any comments left for me to address and I've
mostly been waiting for Joerg to pick it up.

Joerg, can you take this through the iommu tree for 3.17? Will acked
this, but perhaps you were waiting for an ACK from the device tree
bindings maintainers?

Will, perhaps you can get Pawel or Mark to look at this?

Arnd, I'm sure if we had your Acked-by that would go a long way too.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/444b6619/attachment.sig>
