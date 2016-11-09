From: panand@redhat.com (Pratyush Anand)
Date: Wed, 9 Nov 2016 23:09:10 +0530
Subject: [PATCH V2 3/5] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <CAJt8pk9tH5nm5sUsKx-dAvW4uzKP+EoRumhYV1mXsU_mk6dRDg@mail.gmail.com>
References: <cover.1476941895.git.panand@redhat.com>
 <22f4d20911e39efa0b8a6f7082d6839b80bb16b0.1476941895.git.panand@redhat.com>
 <20161108032941.GC20591@arm.com>
 <CAJt8pk9tH5nm5sUsKx-dAvW4uzKP+EoRumhYV1mXsU_mk6dRDg@mail.gmail.com>
Message-ID: <ffe812c9-0f2d-c791-8c93-2ad71849042e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 08 November 2016 05:28 PM, Pavel Labath wrote:
>>> +     if (min_dist > 0 && min_dist != -1) {
>>> >> +             /* No exact match found. */
>>> >> +             wp = slots[closest_match];
>>> >> +             info = counter_arch_bp(wp);
>>> >> +             info->trigger = addr;
>>> >> +             perf_bp_event(wp, regs);
>>> >> +     }
>> >
>> > Why don't we need to bother with the stepping in the case of a non-exact
>> > match?
> Good catch. I think we do. I must have dropped that part somehow.
>
> Pratyush, could you include the attached fixup in the next batch?

Ok, will do.

~Pratyush
