From: r.sricharan@ti.com (Sricharan R)
Date: Sun, 17 Mar 2013 10:30:25 +0530
Subject: [PATCH V6] ARM: LPAE: Fix mapping in alloc_init_section for
 unaligned addresses
In-Reply-To: <CANOGCgNDRb5OT9_D2Kny1_VrKWUVr9B5hjnmJvHpvve7mjidOg@mail.gmail.com>
References: <1360574009-12429-1-git-send-email-r.sricharan@ti.com>
 <20130211131230.GA5676@MacBook-Pro.local> <5118F796.3080308@ti.com>
 <51261288.5030806@ti.com> <51414AFB.9080403@ti.com>
 <20130315173630.GR4977@n2100.arm.linux.org.uk>
 <CANOGCgNDRb5OT9_D2Kny1_VrKWUVr9B5hjnmJvHpvve7mjidOg@mail.gmail.com>
Message-ID: <51454DE9.2070202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Friday 15 March 2013 11:38 PM, Christoffer Dall wrote:
> On Fri, Mar 15, 2013 at 10:36 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Mar 14, 2013 at 09:28:51AM +0530, Sricharan R wrote:
>>> On Thursday 21 February 2013 05:56 PM, R Sricharan wrote:
>>>> Hi,
>>>> On Monday 11 February 2013 07:22 PM, R Sricharan wrote:
>>>>> Hi Russell,
>>>>>
>>>>> On Monday 11 February 2013 06:42 PM, Catalin Marinas wrote:
>>>>>> On Mon, Feb 11, 2013 at 09:13:29AM +0000, R Sricharan wrote:
>>>>>>> +static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>>>>>>> +                      unsigned long end, phys_addr_t phys,
>>>>>>> +                      const struct mem_type *type)
>>>>>>> +{
>>>>>>> +    pmd_t *pmd = pmd_offset(pud, addr);
>>>>>>> +    unsigned long next;
>>>>>>> +
>>>>>>> +    do {
>>>>>>>           /*
>>>>>>> -         * No need to loop; pte's aren't interested in the
>>>>>>> -         * individual L1 entries.
>>>>>>> +         * With LPAE, we must loop over to map
>>>>>>> +         * all the pmds for the given range.
>>>>>>>            */
>>>>>>> -        alloc_init_pte(pmd, addr, end, __phys_to_pfn(phys), type);
>>>>>>> -    }
>>>>>>> +        next = pmd_addr_end(addr, end);
>>>>>>> +
>>>>>>> +        /*
>>>>>>> +         * Try a section mapping - end, addr and phys must all be
>>>>>>> +         * aligned to a section boundary.posted 
>>>>>>> +         */
>>>>>>
>>>>>> Should this read "next, addr and phys" instead of "end..."?
>>>>>>
>>>>>> Otherwise:
>>>>>>
>>>>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>
>>>>>   Can I put this in to patch system ?
>>>>
>>>>    Ping..
>>>>
>>>> Regards,
>>>>  Sricharan
>>>  Ping again..
>>
>> Do we have a winner out of all the patches which have been posted yet?
> 
> I was fine with the latest version if my comments were addressed, but
> I don't remember seeing this version posted.
> 
> Sricharan, can you please post a new complete patch that we can ack,
> and please remember cc'ing me directly so I don't miss it.

  I posted a version after addressing your comments and Catalin
  acked that as well. I will repost again now.

Regards,
 Sricharan


  
