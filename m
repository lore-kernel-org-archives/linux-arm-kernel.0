From: linux.amoon@gmail.com (Anand Moon)
Date: Thu, 26 Jul 2018 12:39:59 +0530
Subject: [PATCH v2 4/4] ARM: exynos: Fix imprecise abort during Exynos5422
 suspend to RAM
In-Reply-To: <CAJKOXPc1csipQsmtJ77uZOwUgchPwGoA_+xxzmCjx97dLU5cyg@mail.gmail.com>
References: <20180724164946.6274-1-krzk@kernel.org>
 <20180724164946.6274-4-krzk@kernel.org>
 <CANAwSgSChhEzDf5oSqZ2Srt62n16Z+ppFnupT=0pGkaSCv90vw@mail.gmail.com>
 <CAJKOXPc1csipQsmtJ77uZOwUgchPwGoA_+xxzmCjx97dLU5cyg@mail.gmail.com>
Message-ID: <CANAwSgS+JNAbiX3=c+OtDBMXgrKcwgC4uRukHG90oCiJcrOxwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 26 July 2018 at 12:10, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 26 July 2018 at 08:22, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Krzysztof,
>>
>> On 24 July 2018 at 22:19, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> Suspend to RAM on Odroid XU3/XU4/HC1 family (Exynos5422) causes
>>> imprecise abort:
>>>
>>>         PM: Syncing filesystems ... done.
>>>         Freezing user space processes ... (elapsed 0.003 seconds) done.
>>>         OOM killer disabled.
>>>         Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
>>>         wake enabled for irq 139
>>>         Disabling non-boot CPUs ...
>>>         IRQ51 no longer affine to CPU1
>>>         IRQ52 no longer affine to CPU2
>>>         IRQ53 no longer affine to CPU3
>>>         IRQ54 no longer affine to CPU4
>>>         IRQ55 no longer affine to CPU5
>>>         IRQ56 no longer affine to CPU6
>>>         cpu cpu4: Dropping the link to regulator.40
>>>         IRQ57 no longer affine to CPU7
>>>         Unhandled fault: external abort on non-linefetch (0x1008) at 0xf081a028
>>>         Internal error: : 1008 [#1] PREEMPT SMP ARM
>>>
>>> with last call trace in exynos_suspend_enter().
>>>
>>> The abort is caused by writing to register in secure part of sysram.
>>> Boards booted under secure firmware (e.g. Hardkernel Odroid boards)
>>> should access non-secure sysram.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>
>>
>> I could not get the suspend to ram working on my Odroid-XU4.
>
> Correct, resuming from suspend to RAM does not work on Exynos5422
> (yet). The patch does not add support for it. I did not write that it
> works. The only thing patch does, is fixing the imprecise abort during
> suspend.
>
> Best regards,
> Krzysztof

Ok thanks for the input.

Best Regards
-Anand
