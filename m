From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 10 Jun 2015 16:07:28 +0200
Subject: [PATCH] ARM: Re-enable TRACE_IRQFLAGS_SUPPORT on ARMv7-M
In-Reply-To: <5577246B.3080602@linaro.org>
References: <1433802288-25508-1-git-send-email-mcoquelin.stm32@gmail.com>
 <20150608224749.GB7557@n2100.arm.linux.org.uk>
 <CALszF6DPzhAufUyWW-a3X7Cp4=tjSyCBM=Y4LcnWnUH=41qeoQ@mail.gmail.com>
 <5576D0FE.10900@linaro.org>
 <20150609150127.GF7557@n2100.arm.linux.org.uk>
 <5577246B.3080602@linaro.org>
Message-ID: <CAGhQ9VzdZRVJsfaod6s7_U7Bgw7kKbXhjVG=BR8tARigKha0Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 9 June 2015 at 19:37, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> On 09/06/15 16:01, Russell King - ARM Linux wrote:
>>
>> On Tue, Jun 09, 2015 at 12:41:50PM +0100, Daniel Thompson wrote:
>>>
>>> Does the following patch, which makes the arch_irqs_disabled()
>>> implementation from asm-generic available on arm, fix the build for you?
>>
>>
>> Yes, this is exactly the kind of fix for this I'm looking for.  Once
>> everyone's happy with it, it can find it's way to the patch system.
>
>
> From my side, using v4.1-rc6 plus the patch, I can build all defconfigs and
> both versatile_defconfig and multi_v7_defconfig remain bootable (so both
> ways through the arch #ifdef in irqflag.h).
>
> Similarly working on linux-next-20150608 plus the patch I am able to build
> and boot Maxime's stm32 code (and show that without the patch it doesn't
> build).
>
> From my side I think that makes it good to go.

Since next didn't build for me either I applied this and it works for
the LPC18xx (Cortex-M4) platform.

Tested-by: Joachim Eastwood <manabian@gmail.com>

regards,
Joachim Eastwood
