From: Pavel.Tatashin@microsoft.com (Pasha Tatashin)
Date: Thu, 23 Aug 2018 13:14:10 +0000
Subject: A crash on ARM64 in move_freepages_block due to uninitialized
 pages in reserved memory
In-Reply-To: <777276b8-9cd6-da4b-d1d9-c60f96a58122@microsoft.com>
References: <alpine.LRH.2.02.1808171527220.2385@file01.intranet.prod.int.rdu2.redhat.com>
 <20180821104418.GA16611@dhcp22.suse.cz>
 <e35b7c14-c7ea-412d-2763-c961b74576f3@arm.com>
 <alpine.LRH.2.02.1808220808050.17906@file01.intranet.prod.int.rdu2.redhat.com>
 <20180823111024.GC29735@dhcp22.suse.cz>
 <alpine.LRH.2.02.1808230715050.30076@file01.intranet.prod.int.rdu2.redhat.com>
 <20180823112359.GE29735@dhcp22.suse.cz>
 <777276b8-9cd6-da4b-d1d9-c60f96a58122@microsoft.com>
Message-ID: <e27d6fcc-e860-8d51-1d0c-27391dca1b7b@microsoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/23/18 9:13 AM, Pavel Tatashin wrote:
> On 8/23/18 7:23 AM, Michal Hocko wrote:
>> On Thu 23-08-18 07:16:34, Mikulas Patocka wrote:
>>>
>>>
>>> On Thu, 23 Aug 2018, Michal Hocko wrote:
>>>
>>>> On Thu 23-08-18 07:02:37, Mikulas Patocka wrote:
>>>> [...]
>>>>> This crash is not from -ENOENT. It crashes because page->compound_head is 
>>>>> 0xffffffffffffffff (see below).
>>>>>
>>>>> If I enable CONFIG_DEBUG_VM, I also get VM_BUG.
>>>>
>>>> This smells like the struct page is not initialized properly. How is
>>>> this memory range added? I mean is it brought up by the memory hotplug
>>>> or during the boot?
> 
> I believe it is due to uninitialized struct pages. Mikulas, could you
> please provide config file, and also the full console output.
> 
> Please make sure that you have:
> CONFIG_DEBUG_VM=y
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y

I meant:
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_VM_PGFLAGS=y

> 
> I wonder what kind of struct page memory layout is used, and also if
> deferred struct pages are enabled or not.
> 
> Have you tried bisecting the problem?
> 
> Thank you,
> Pavel
> 
