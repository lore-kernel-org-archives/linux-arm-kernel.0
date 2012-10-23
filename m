From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 23 Oct 2012 12:23:10 +0200
Subject: [PATCH V6 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <20121023100057.GS21164@n2100.arm.linux.org.uk>
References: <CAHkRjk7YdzB_RMCjY7SkzPVwEvuk17akJxaNeNmAuqZpwX_kfQ@mail.gmail.com>
 <1348738523-28609-1-git-send-email-gregory.clement@free-electrons.com>
 <1348738523-28609-2-git-send-email-gregory.clement@free-electrons.com>
 <20121023090154.GP21164@n2100.arm.linux.org.uk>
 <508666A6.9040701@free-electrons.com>
 <20121023100057.GS21164@n2100.arm.linux.org.uk>
Message-ID: <5086700E.10702@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 12:00 PM, Russell King - ARM Linux wrote:
> On Tue, Oct 23, 2012 at 11:43:02AM +0200, Gregory CLEMENT wrote:
>> On 10/23/2012 11:01 AM, Russell King - ARM Linux wrote:
>>> On Thu, Sep 27, 2012 at 11:35:23AM +0200, Gregory CLEMENT wrote:
>>>> Aurora Cache Controller was designed to be compatible with the ARM L2
>>>> Cache Controller. It comes with some difference or improvement such
>>>> as:
>>>> - no cache id part number available through hardware (need to get it
>>>>   by the DT).
>>>> - always write through mode available.
>>>> - two flavors of the controller outer cache and system cache (meaning
>>>>   maintenance operations on L1 are broadcasted to the L2 and L2
>>>>   performs the same operation).
>>>> - in outer cache mode, the cache maintenance operations are improved and
>>>>   can be done on a range inside a page and are not limited to a cache
>>>>   line.
>>>
>>> This adds new build warnings:
>>>
>>> arch/arm/mm/cache-l2x0.c:328:13: warning: 'aurora_inv_range' defined but not used
>>> arch/arm/mm/cache-l2x0.c:347:13: warning: 'aurora_clean_range' defined but not used
>>> arch/arm/mm/cache-l2x0.c:365:13: warning: 'aurora_flush_range' defined but not used
>>>
>>> to the realview build (non-DT).  Please investigate, thanks.
>>
>> OK I found the problem: aurora cache support is new so it is only
>> enable with device tree support. I moved all this functions in the
>> under OF_CONFIG (see the patch below). Do you want I submit it on the
>> patch system, or can you get it directly from this email?
> 
> Easier by the patch system, and much less likely to get buried and lost
> between now and when I do the update, thanks.
> 
OK, the initial patch 7547/1 was superseded by the patch 7547/2 that I have just
pushed in the patch system. I hope I have done it right.

Thanks,

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
