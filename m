From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Mar 2017 16:42:41 +0000
Subject: [PATCH v2 0/5] Implement SMMU passthrough using the default domain
In-Reply-To: <20170321154624.GC29659@8bytes.org>
References: <1489178976-15353-1-git-send-email-will.deacon@arm.com>
 <20170321154624.GC29659@8bytes.org>
Message-ID: <20170321164241.GD30948@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Tue, Mar 21, 2017 at 04:46:24PM +0100, Joerg Roedel wrote:
> On Fri, Mar 10, 2017 at 08:49:31PM +0000, Will Deacon wrote:
> > Will Deacon (5):
> >   iommu/arm-smmu: Restrict domain attributes to UNMANAGED domains
> >   iommu/arm-smmu: Install bypass S2CRs for IOMMU_DOMAIN_IDENTITY domains
> >   iommu/arm-smmu-v3: Make arm_smmu_install_ste_for_dev return void
> >   iommu/arm-smmu-v3: Install bypass STEs for IOMMU_DOMAIN_IDENTITY
> >     domains
> >   iommu: Allow default domain type to be set on the kernel command line
> > 
> >  Documentation/admin-guide/kernel-parameters.txt |  6 ++
> >  drivers/iommu/arm-smmu-v3.c                     | 76 +++++++++++++++----------
> >  drivers/iommu/arm-smmu.c                        | 26 ++++++++-
> >  drivers/iommu/iommu.c                           | 17 +++++-
> >  4 files changed, 90 insertions(+), 35 deletions(-)
> 
> Besides my one comment on the last patch this series looks good to me.
> Do you plan to include it (with the fall-back) into your pull-request?

Yes, that would certainly be easiest for me, given the changes to the
SMMU drivers. However, if you prefer it separately then I can do that too.

Cheers,

Will
