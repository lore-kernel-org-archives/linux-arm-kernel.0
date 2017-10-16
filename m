From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 16 Oct 2017 14:18:00 +0100
Subject: [PATCH v2 0/4] SMMUv3 CMD_SYNC optimisation
In-Reply-To: <20171013190521.GD30572@arm.com>
References: <cover.1504182142.git.robin.murphy@arm.com>
 <20171013190521.GD30572@arm.com>
Message-ID: <0414f685-1673-bb4e-bd7a-b99f2054b86e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/17 20:05, Will Deacon wrote:
> Hi Robin,
> 
> On Thu, Aug 31, 2017 at 02:44:24PM +0100, Robin Murphy wrote:
>> Since Nate reported a reasonable performance boost from the out-of-line
>> MSI polling in v1 [1], I've now implemented the equivalent for cons
>> polling as well - that has been boot-tested on D05 with some trivial I/O
>> and at least doesn't seem to lock up or explode. There's also a little
>> cosmetic tweaking to make the patches a bit cleaner as a series.
>>
>> Robin.
>>
>> [1] https://www.mail-archive.com/iommu at lists.linux-foundation.org/msg19657.html
>>
>> Robin Murphy (5):
>>   iommu/arm-smmu-v3: Specialise CMD_SYNC handling
>>   iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
>>   iommu/arm-smmu-v3: Use CMD_SYNC completion interrupt
>>   iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq lock
>>   iommu/arm-smmu-v3: Use burst-polling for sync completion
> 
> What's this final mythical patch about? I don't see it in the series.

It's in the place 5/5 would be, I just tagged it as [RFT] since I have
zero evidence whether it's worth the bother or not.

> Anyway, the first two patches look fine to me, but this doesn't apply
> on top of my iommu/devel branch so they will need rebasing.

Will do.

Thanks for the review,
Robin.
