From: alex.williamson@redhat.com (Alex Williamson)
Date: Tue, 23 Sep 2014 16:14:10 -0600
Subject: [PATCHv7 01/26] iommu/arm-smmu: change IOMMU_EXEC to IOMMU_NOEXEC
In-Reply-To: <20140923145816.GE28608@arm.com>
References: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
 <1411483586-29304-2-git-send-email-a.motakis@virtualopensystems.com>
 <20140923145816.GE28608@arm.com>
Message-ID: <1411510450.24563.44.camel@ul30vt.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-23 at 15:58 +0100, Will Deacon wrote:
> Hi Antonios,
> 
> On Tue, Sep 23, 2014 at 03:46:00PM +0100, Antonios Motakis wrote:
> > Exposing the XN flag of the SMMU driver as IOMMU_NOEXEC instead of
> > IOMMU_EXEC makes it enforceable, since for IOMMUs that don't support
> > the XN flag pages will always be executable.
> > 
> > Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
> > ---
> >  drivers/iommu/arm-smmu.c | 9 +++++----
> >  include/linux/iommu.h    | 2 +-
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> [...]
> 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 20f9a52..e1a644c 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -27,7 +27,7 @@
> >  #define IOMMU_READ	(1 << 0)
> >  #define IOMMU_WRITE	(1 << 1)
> >  #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
> > -#define IOMMU_EXEC	(1 << 3)
> > +#define IOMMU_NOEXEC	(1 << 3)
> 
> This hunk needs to be a separate patch merged by Joerg before I can take the
> arm-smmu part (which looks fine).

That separate hunk would be unbuildable since arm-smmu depends on the
IOMMU_EXEC define.  Patch 2/ is also in iommu code and gates patch 3/ in
arm-smmu.  The IOMMU-core changes are pretty trivial, so perhaps Joerg
would be willing to ACK 1&2 and let Will include the first 3 patches
through his tree.

These first 3 patches should have been sent on their own since they're
small an obvious so they don't get hung up on the reset of the series.
Thanks,

Alex
