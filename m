From: bobby.prani@gmail.com (Pranith Kumar)
Date: Fri, 27 Feb 2015 15:29:38 -0500
Subject: [RFC PATCH] arm64: cmpxchg.h: Bring ldxr and stxr closer
In-Reply-To: <CAJhHMCA0La6rQBndxJDnynAZ6AogEbKcCRQULZjjRTXBMzGuiA@mail.gmail.com>
References: <1425067776-2794-1-git-send-email-bobby.prani@gmail.com>
 <20150227201526.GH24818@arm.com>
 <CAJhHMCA0La6rQBndxJDnynAZ6AogEbKcCRQULZjjRTXBMzGuiA@mail.gmail.com>
Message-ID: <CAJhHMCDUqvxs4rwsnw69UyM5NoBTit_HoYzdWpSYibbXtRs=5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 3:17 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> On Fri, Feb 27, 2015 at 3:15 PM, Will Deacon <will.deacon@arm.com> wrote:
>>> @@ -166,11 +166,11 @@ static inline int __cmpxchg_double(volatile void *ptr1, volatile void *ptr2,
>>>               VM_BUG_ON((unsigned long *)ptr2 - (unsigned long *)ptr1 != 1);
>>>               do {
>>>                       asm volatile("// __cmpxchg_double8\n"
>>> +                     "       mov     %w0, #0\n"
>>>                       "       ldxp    %0, %1, %2\n"
>>
>> Seriously, you might want to test this before you mindlessly make changes to
>> low-level synchronisation code. Not only is the change completely unnecessary
>> but it is actively harmful.
>>
>
> Oops, I apologize for this. I should have looked more closely. It is
> wrong to do this in cmpxchg_double(). What about the other cases?
>

Hi Will,

I tried looking closely on what might be the problem here. I am
waiting on a HiKey arm64 board and I agree I should not send in
changes without running/testing them first.

Could you please explain (for educational purposes) why you think this
change is harmful?


Thanks,
-- 
Pranith
