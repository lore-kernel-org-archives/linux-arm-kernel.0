From: will.deacon@arm.com (Will Deacon)
Date: Tue, 2 Dec 2014 09:26:38 +0000
Subject: [PATCH 5/7] iommu/arm-smmu: don't bother truncating the s1
 output size to VA_BITS
In-Reply-To: <87mw77cdft.fsf@igel.home>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
 <1409849405-17347-6-git-send-email-will.deacon@arm.com>
 <87mw77cdft.fsf@igel.home>
Message-ID: <20141202092638.GA9917@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 08:39:18PM +0000, Andreas Schwab wrote:
> Will Deacon <will.deacon@arm.com> writes:
> 
> > diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> > index ecad700cd4f4..2a7e3331b93a 100644
> > --- a/drivers/iommu/arm-smmu.c
> > +++ b/drivers/iommu/arm-smmu.c
> > @@ -24,7 +24,7 @@
> >   *	- v7/v8 long-descriptor format
> >   *	- Non-secure access to the SMMU
> >   *	- 4k and 64k pages, with contiguous pte hints.
> > - *	- Up to 42-bit addressing (dependent on VA_BITS)
> > + *	- Up to 48-bit addressing (dependent on VA_BITS)
> 
> Does that mean that the dependency on !ARM_SMMU for ARM64_VA_BITS_48 is
> obsolete?

No, you need my other patch series for that (we don't handle stage-2
properly without it):

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/306786.html

Will
