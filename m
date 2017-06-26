From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Mon, 26 Jun 2017 21:19:40 +0800
Subject: [PATCH v2 0/8] io-pgtable lock removal
In-Reply-To: <15e7ce0a-bf4b-cc77-3600-c37ed865a4d7@huawei.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
 <61b7b953-5bf4-eb45-c3e8-b4491e8fdca7@huawei.com>
 <f694a247-9006-3a3c-8a77-209b158eabf3@arm.com>
 <9bbf18c7-34ba-6e94-53bd-3f75059c1bb2@huawei.com>
 <a75e4c19-e393-f030-6927-debae27957eb@arm.com>
 <15e7ce0a-bf4b-cc77-3600-c37ed865a4d7@huawei.com>
Message-ID: <595109EC.5000201@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/6/26 21:12, John Garry wrote:
> 
>>>
>>> I saw Will has already sent the pull request. But, FWIW, we are seeing
>>> roughly the same performance as v1 patchset. For PCI NIC, Zhou again
>>> found performance drop goes from ~15->8% with SMMU enabled, and for
>>> integrated storage controller [platform device], we still see a drop of
>>> about 50%, depending on datarates (Leizhen has been working on fixing
>>> this).
>>
>> Thanks for confirming. Following Joerg's suggestion that the storage
>> workloads may still depend on rbtree performance - it had slipped my
>> mind that even with small block sizes those could well be grouped into
>> scatterlists large enough to trigger a >64-page IOVA allocation - I've
>> taken the liberty of cooking up a simplified version of Leizhen's rbtree
>> optimisation series in the iommu/iova branch of my tree. I'll follow up
>> on that after the merge window, but if anyone wants to play with it in
>> the meantime feel free.
The main problem is lock confliction of cmd queue. I have prepared my patchset,
I will send it later.

> 
> Just a reminder that we did also see poor performance with our integrated NIC on your v1 patchset also (I can push for v2 patchset testing, but expect the same).
> 
> We might be able to now include a LSI 3108 PCI SAS card in our testing also to give a broader set of results.
> 
> John
> 
>>
>> Robin.
>>
>> .
>>
> 
> 
> 
> .
> 

-- 
Thanks!
BestRegards
