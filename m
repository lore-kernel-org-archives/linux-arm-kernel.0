From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 13 Mar 2013 11:22:30 +0000
Subject: [PATCH] ARM: proc: Add Krait proc info
In-Reply-To: <513FD702.5010408@codeaurora.org>
References: <1362439299-29617-1-git-send-email-sboyd@codeaurora.org>
 <20130305083421.GA19391@mudshark.cambridge.arm.com>
 <51366B9E.7010502@codeaurora.org> <5136D220.5090904@codeaurora.org>
 <20130308064139.GA31156@mudshark.cambridge.arm.com>
 <513FD702.5010408@codeaurora.org>
Message-ID: <51406176.8020000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/13 01:31, Stephen Boyd wrote:
> On 03/07/13 22:41, Will Deacon wrote:
>> On Wed, Mar 06, 2013 at 05:20:32AM +0000, Stephen Boyd wrote:
>>> On 03/05/13 14:03, Stephen Boyd wrote:
>>>> On 03/05/13 00:34, Will Deacon wrote:
>>>>> I was looking at this the other day and wondered whether we could set
>>>>> HWCAP_IDIV in __v7_setup, depending on ID_ISAR0[27:24]. I can't immediately
>>>>> think why that would be difficult, but similarly there may well be a reason
>>>>> why we assign it like this.
>>>>>
>>>>> Fancy taking a look?
>>>> Ok I'll take a look.
>>> Hmm. I wonder if we did it this way because between version B and C of
>>> DDI0406 the definition of those bits changed.
>>>
>>> In DDI0406B we have
>>>
>>>      0 - no support
>>>      1 - support
>>>
>>> and in DDI0406C we have
>>>
>>>      0 - no support
>>>      1 - support in Thumb
>>>      2 - support in Thumb and ARM
>> Well spotted, although I think this a documentation error. I've checked both
>> A7 and A15 and they both advertise '2' (although r0p0 TRM for A7 also gets
>> this wrong, the CPU does the right thing).
>
> What about the Cortex-R7? When I google "ARM ISAR0" the first hit is
>
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0363e/Bgbfafej.html
>

That appears to be an R4 TRM, but I've checked the details for R4, 5 and 7.

In R4 there is no ARM hardware divide, so the document that you linked 
to is correct in specifying only 0b1

In R5, ARM hardware divide was added in r0p1, and the value of 
ID_ISAR0[27:24] is updated to 0b10 accordingly

In R7, the TRM just refers you to the ARMARM, but the hardware guys 
assure me that ID_ISAR0[27:24] will be accurately 1, or 2 depending on 
what the processor actually supports.

Hope that helps,
Jonny
