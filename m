From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Tue, 11 Oct 2016 19:04:24 +0800
Subject: [PATCH v8 10/16] mm/memblock: add a new function
 memblock_alloc_near_nid
In-Reply-To: <20161011101623.GC23648@arm.com>
References: <1472712907-12700-1-git-send-email-thunder.leizhen@huawei.com>
 <1472712907-12700-11-git-send-email-thunder.leizhen@huawei.com>
 <57FC43F4.1020909@huawei.com> <20161011101623.GC23648@arm.com>
Message-ID: <57FCC738.7050005@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/11 18:16, Will Deacon wrote:
> On Tue, Oct 11, 2016 at 09:44:20AM +0800, Leizhen (ThunderTown) wrote:
>> On 2016/9/1 14:55, Zhen Lei wrote:
>>> If HAVE_MEMORYLESS_NODES is selected, and some memoryless numa nodes are
>>> actually exist. The percpu variable areas and numa control blocks of that
>>> memoryless numa nodes must be allocated from the nearest available node
>>> to improve performance.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>  include/linux/memblock.h |  1 +
>>>  mm/memblock.c            | 28 ++++++++++++++++++++++++++++
>>>  2 files changed, 29 insertions(+)
>>
>> Hi Will,
>>   It seems no one take care about this, how about I move below function into arch/arm64/mm/numa.c
>> again? So that, merge it and patch 11 into one.
> 
> I'd rather you reposted it after the merge window so we can see what to
> do with it then. The previous posting was really hard to figure out and
> mixed lots of different concepts into one series, so it's not completely
> surprising that it didn't all get picked up.
OK, thanks.

> 
> Will
> 
> .
> 
