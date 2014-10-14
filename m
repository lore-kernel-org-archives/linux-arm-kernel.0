From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue, 14 Oct 2014 14:50:07 -0700
Subject: [PATCH v4 4/6] ARM: rockchip: add basic smp support for rk3288
In-Reply-To: <1453932.GC4UXrUPRz@phil>
References: <1413231122-1770-1-git-send-email-kever.yang@rock-chips.com>
 <1413231122-1770-5-git-send-email-kever.yang@rock-chips.com>
 <CAD=FV=WGnE3fBfzLGN_x8dFqq4RV=OnVAyUgRQheMiyG4U7TkQ@mail.gmail.com>
 <1453932.GC4UXrUPRz@phil>
Message-ID: <543D9A8F.3040304@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On 10/14/2014 02:23 PM, Heiko St?bner wrote:
> Am Dienstag, 14. Oktober 2014, 13:24:03 schrieb Doug Anderson:
>> Kever,
>>
>> On Mon, Oct 13, 2014 at 1:12 PM, Kever Yang <kever.yang@rock-chips.com>
> wrote:
>>> +       /*
>>> +        * We need to soft reset the cpu when we turn off the cpu power
>>> domain, +        * or else the active processors might be stalled when
>>> the individual +        * processor is powered down.
>>> +        */
>>> +       if (read_cpuid_part_number() != ARM_CPU_PART_CORTEX_A9) {
>> I haven't done a full review of this patch, but it seems unlikely that
>> your uses of read_cpuid_part_number() and read_cpuid_part() in this
>> patch are correct.  You use both functions and in both cases compare
>> the results to ARM_CPU_PART_CORTEX_A9.
> I think read_cpuid_part() would be the correct one, as it does
You are right, read_cpuid_part() is correct one on kernel next,
I mix up 3.14 kernel and next tree, only read_cpuid_part_number() is 
available
in 3.14 kernel.

I will correct it in my next version, any other changes needed for new 
version?

- Kever.
