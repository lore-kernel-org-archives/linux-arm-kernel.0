From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 9 Aug 2013 15:37:12 -0400
Subject: [PATCH v2 4/6] ARM: mm: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <51FD56D4.5020705@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <1375289086-5315-5-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1308022156120.14472@syhkavp.arg> <51FCFBE1.5090000@ti.com>
 <20130803140544.GB23006@n2100.arm.linux.org.uk>
 <20130803140948.GC23006@n2100.arm.linux.org.uk> <51FD56D4.5020705@ti.com>
Message-ID: <520544E8.8040809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Saturday 03 August 2013 03:15 PM, Santosh Shilimkar wrote:
> On Saturday 03 August 2013 10:09 AM, Russell King - ARM Linux wrote:
>> On Sat, Aug 03, 2013 at 03:05:44PM +0100, Russell King - ARM Linux wrote:
>>> On Sat, Aug 03, 2013 at 06:17:29PM +0530, Sricharan R wrote:
>>>>   I started with this kind of augmenting with the immediate operand
>>>>   while starting V2. But the problem was, we do the runtime patching twice.
>>>
>>> It might be much better to do this only once, and instead of having the
>>> early code overwrite the page table in use, create a new page table with
>>> all the correct page table entries in and switch to that.
>>
> The twice patching approach was taken obviously from the last discussion
> where you suggested to avoid too many changes to the existing patching
> code on Cyril's proposal. And the idea was obvious to delay the patching
> as late as machine code initialization so that it easy to patch and maintain.
>  
>> Note: we still need to do a certain amount of modification of the existing
>> page table so that we _can_ perform such a switch on all our CPUs - that
>> is, ensuring that the region for flushing the CPU caches on processors
>> which need it is properly mapped.
>>
> We probably need some more guidance on this approach. Last attempt was
> more or less removing the early patching code and operating directly
> on pv_offset variable to start with. And then in late code patching
> the stub itself were built to operate on pv_offsets. You didn't like
> that approach so to ensure that we follow your idea properly some
> more explanation would help.
> 
Considering the $subject patch is now more or less sorted out, I
would like to hear on your idea about one time patching.

Thanks

Regards,
Santosh
