From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Mar 2016 13:35:01 +0000
Subject: [PATCH] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
In-Reply-To: <C2D36A36-8247-4432-BE50-14129D9D8E5B@caviumnetworks.com>
References: <1456348433-3337-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160302030756.GC7637@arm.com>
 <C2D36A36-8247-4432-BE50-14129D9D8E5B@caviumnetworks.com>
Message-ID: <20160302133457.GD7637@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:23:57AM +0000, Chalamarla, Tirumalesh wrote:
> On 3/1/16, 7:07 PM, "Will Deacon" <will.deacon@arm.com> wrote:
> >On Wed, Feb 24, 2016 at 01:13:53PM -0800, Tirumalesh Chalamarla wrote:
> >> +		smmu->cavium_smmu_id = cavium_smmu_count;
> >> +		cavium_smmu_count++;
> >> +		smmu->cavium_id_base =
> >> +			(smmu->cavium_smmu_id * ARM_SMMU_MAX_CBS);
> >
> >Can you not use num_context_banks here, instead of the constant?
> We need total context banks so far, so ARM_SMMU_MAX_CBS is best option.
> For Thunder both are same anyway. 

Hmm, so couldn't you instead just update a running total as you go along?
That is, initialise it to zero, then atomic_add_return(num_context_banks)
when you probe?

Will
