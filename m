From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 23 Sep 2014 19:41:43 +0200
Subject: [PATCH v2] ARM: zImage: add support for ARMv7-M
In-Reply-To: <20140923163347.GE6858@e104818-lin.cambridge.arm.com>
References: <1411057343-20861-1-git-send-email-manabian@gmail.com>
 <1411147367-26824-1-git-send-email-manabian@gmail.com>
 <20140923163347.GE6858@e104818-lin.cambridge.arm.com>
Message-ID: <CAGhQ9VyZ4ZPNNDm9TNJKiQ2zufasr2vkbepFsg-K+raUha0_8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 September 2014 18:33, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Sep 19, 2014 at 06:22:47PM +0100, Joachim Eastwood wrote:
>>               .align
>> -             .arm                            @ Always enter in ARM state
>> + AR_CLASS(   .arm    )               @ Always enter in ARM state for AR class
>
> Nitpick: A/R class (or classes).

Sure.

>> +#elif defined(CONFIG_CPU_V7M)
>> +             ldr     r9, =0xe000ed00         @ CPUID register address
>
> Another nitpick: can you use some macro? We define them in
> arch/arm/include/asm/v7m.h, so you could write the above as (untested):
>
>                 ldr     r9, =BASEADDR_V7M_SCB + V7M_SCB_CPUID

I'll use the version from head-nommu.S, which does this:
ldr r9, =BASEADDR_V7M_SCB
ldr r9, [r9, V7M_SCB_CPUID]

I'll send out an updated patch soon.

regards
Joachim Eastwood
