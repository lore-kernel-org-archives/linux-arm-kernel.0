From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 14 Oct 2013 09:48:49 -0400
Subject: [RFC 06/23] mm/memblock: Add memblock early memory allocation apis
In-Reply-To: <20131013184212.GA18075@htj.dyndns.org>
References: <1381615146-20342-1-git-send-email-santosh.shilimkar@ti.com>
 <1381615146-20342-7-git-send-email-santosh.shilimkar@ti.com>
 <20131013175648.GC5253@mtj.dyndns.org>
 <20131013180058.GG25034@n2100.arm.linux.org.uk>
 <20131013184212.GA18075@htj.dyndns.org>
Message-ID: <525BF641.3000300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 13 October 2013 02:42 PM, Tejun Heo wrote:
> On Sun, Oct 13, 2013 at 07:00:59PM +0100, Russell King - ARM Linux wrote:
>> On Sun, Oct 13, 2013 at 01:56:48PM -0400, Tejun Heo wrote:
>>> Hello,
>>>
>>> On Sat, Oct 12, 2013 at 05:58:49PM -0400, Santosh Shilimkar wrote:
>>>> Introduce memblock early memory allocation APIs which allow to support
>>>> LPAE extension on 32 bits archs. More over, this is the next step
>>>
>>> LPAE isn't something people outside arm circle would understand.
>>> Let's stick to highmem.
>>
>> LPAE != highmem.  Two totally different things, unless you believe
>> system memory always starts at physical address zero, which is very
>> far from the case on the majority of ARM platforms.
>>
thanks Russell for clarification.

>> So replacing LPAE with "highmem" is pure misrepresentation and is
>> inaccurate.  PAE might be a better term, and is also the x86 term
>> for this.
> 
> Ah, right, forgot about the base address.  Let's please spell out the
> requirements then.  Briefly explaining both aspects (non-zero base
> addr & highmem) and why the existing bootmem based interfaced can't
> serve them would be helpful to later readers.
> 
OK. Will try to describe bit more in the next version.Cover letter had
some of the information on the requirement which I will also
mention in the patch commit in next version.

Regards,
Santosh
