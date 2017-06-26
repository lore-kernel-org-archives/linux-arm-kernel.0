From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 26 Jun 2017 13:31:35 +0100
Subject: [PATCH v2 0/8] io-pgtable lock removal
In-Reply-To: <9bbf18c7-34ba-6e94-53bd-3f75059c1bb2@huawei.com>
References: <cover.1498145008.git.robin.murphy@arm.com>
 <61b7b953-5bf4-eb45-c3e8-b4491e8fdca7@huawei.com>
 <f694a247-9006-3a3c-8a77-209b158eabf3@arm.com>
 <9bbf18c7-34ba-6e94-53bd-3f75059c1bb2@huawei.com>
Message-ID: <a75e4c19-e393-f030-6927-debae27957eb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/17 12:35, John Garry wrote:
> On 23/06/2017 10:58, Robin Murphy wrote:
>> On 23/06/17 09:47, John Garry wrote:
>>> On 22/06/2017 16:53, Robin Murphy wrote:
>>>> The feedback has been promising, so v2 is just a final update to cover
>>>> a handful of memory ordering and cosmetic tweaks that came up when Will
>>>> and I went through this offline.
>>>>
>>>> Thanks,
>>>> Robin.
>>>
>>> Hi Robin,
>>>
>>> Is it worth us retesting this patchset?
>>>
>>> If yes, as for a branch (for convenience), does this one now match v2:
>>> git://linux-arm.org/linux-rm  iommu/pgtable
>>>
>>> I saw it was rewritten recently.
>>
>> Indeed, I pushed the branch out before posting. Functionally it ought to
>> be identical to v1, so this was more just a heads-up - feel free to
>> double-check I've not broken anything, but I wouldn't say you need to
>> throw the full test lab at it again.
>>
> 
> I saw Will has already sent the pull request. But, FWIW, we are seeing
> roughly the same performance as v1 patchset. For PCI NIC, Zhou again
> found performance drop goes from ~15->8% with SMMU enabled, and for
> integrated storage controller [platform device], we still see a drop of
> about 50%, depending on datarates (Leizhen has been working on fixing
> this).

Thanks for confirming. Following Joerg's suggestion that the storage
workloads may still depend on rbtree performance - it had slipped my
mind that even with small block sizes those could well be grouped into
scatterlists large enough to trigger a >64-page IOVA allocation - I've
taken the liberty of cooking up a simplified version of Leizhen's rbtree
optimisation series in the iommu/iova branch of my tree. I'll follow up
on that after the merge window, but if anyone wants to play with it in
the meantime feel free.

Robin.
