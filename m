From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Jul 2015 13:48:47 +0100
Subject: [PATCH v3 0/5] iommu/arm-smmu: add support for non-pci devices
In-Reply-To: <55AE1F2F.3090106@arm.com>
References: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
 <55AE1F2F.3090106@arm.com>
Message-ID: <20150728124847.GL29209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 11:30:07AM +0100, Robin Murphy wrote:
> On 21/07/15 08:30, Zhen Lei wrote:
> > Changelog:
> > v2 -> v3:
> > 1. add support for pci device hotplug, which missed in patch v2.
> > 2. only support #iommu-cells = <1>, add corresponding description in arm,smmu-v3.txt.
> > 3. add function find_smmu_by_device which extracted from find_smmu_by_node, to resolve
> >     the problem mentioned by Robin Murphy in [PATCH v2 7/9].
> >     Additionally:
> >     +    platform_set_drvdata(pdev, smmu);       //Patch v2
> >     +	dev->archdata.iommu = smmu;             //Patch v3, dev = &pdev->dev
> 
> 
> I didn't give any Reviewed-by tags, much less to revised patches that 
> I've not even looked at yet; please see section 13 of 
> Documentation/SubmittingPatches for what the Reviewed-by tag means.

That said, it would be great if you could review the patches anyway ;)

Also, it looks like this is all based on Laurent's IOMMU probe deferral
series which hasn't seen any movement for a while.

Laurent: are you planning to repost that, or is it worth us picking up
the original version and bashing it into shape ourselves?

Will
