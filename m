From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Thu, 27 Oct 2016 16:23:10 +0800
Subject: [PATCH 1/2] mm/memblock: prepare a capability to support memblock
 near alloc
In-Reply-To: <20161027072235.GB6454@dhcp22.suse.cz>
References: <1477364358-10620-1-git-send-email-thunder.leizhen@huawei.com>
 <1477364358-10620-2-git-send-email-thunder.leizhen@huawei.com>
 <20161025132338.GA31239@dhcp22.suse.cz> <58101EB4.2080305@huawei.com>
 <20161026093152.GE18382@dhcp22.suse.cz> <58116954.8080908@huawei.com>
 <20161027072235.GB6454@dhcp22.suse.cz>
Message-ID: <5811B96E.8040800@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/27 15:22, Michal Hocko wrote:
> On Thu 27-10-16 10:41:24, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2016/10/26 17:31, Michal Hocko wrote:
>>> On Wed 26-10-16 11:10:44, Leizhen (ThunderTown) wrote:
>>>>
>>>>
>>>> On 2016/10/25 21:23, Michal Hocko wrote:
>>>>> On Tue 25-10-16 10:59:17, Zhen Lei wrote:
>>>>>> If HAVE_MEMORYLESS_NODES is selected, and some memoryless numa nodes are
>>>>>> actually exist. The percpu variable areas and numa control blocks of that
>>>>>> memoryless numa nodes need to be allocated from the nearest available
>>>>>> node to improve performance.
>>>>>>
>>>>>> Although memblock_alloc_try_nid and memblock_virt_alloc_try_nid try the
>>>>>> specified nid at the first time, but if that allocation failed it will
>>>>>> directly drop to use NUMA_NO_NODE. This mean any nodes maybe possible at
>>>>>> the second time.
>>>>>>
>>>>>> To compatible the above old scene, I use a marco node_distance_ready to
>>>>>> control it. By default, the marco node_distance_ready is not defined in
>>>>>> any platforms, the above mentioned functions will work as normal as
>>>>>> before. Otherwise, they will try the nearest node first.
>>>>>
>>>>> I am sorry but it is absolutely unclear to me _what_ is the motivation
>>>>> of the patch. Is this a performance optimization, correctness issue or
>>>>> something else? Could you please restate what is the problem, why do you
>>>>> think it has to be fixed at memblock layer and describe what the actual
>>>>> fix is please?
>>>>
>>>> This is a performance optimization.
>>>
>>> Do you have any numbers to back the improvements?
>>
>> I have not collected any performance data, but at least in theory,
>> it's beneficial and harmless, except make code looks a bit
>> urly.
> 
> The whole memoryless area is cluttered with hacks because everybody just
> adds pieces here and there to make his particular usecase work IMHO.
> Adding more on top for performance reasons which are even not measured
OK, I will ask my colleagues for help, whether some APPs can be used or not.

> to prove a clear win is a no go. Please step back try to think how this
> could be done with an existing infrastructure we have (some cleanups
OK, I will try to do it. But some infrastructures maybe only restricted in the
theoretical analysis, I don't have the related testing environment, so there is
no way to verify.


> while doing that would be hugely appreciated) and if that is not
> possible then explain why and why it is not feasible to fix that before
I think it will be feasible.

> you start adding a new API.
> 
> Thanks!
> 
