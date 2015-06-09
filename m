From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 9 Jun 2015 16:42:30 +0200
Subject: [PATCH] ARM: Re-enable TRACE_IRQFLAGS_SUPPORT on ARMv7-M
In-Reply-To: <5576D0FE.10900@linaro.org>
References: <1433802288-25508-1-git-send-email-mcoquelin.stm32@gmail.com>
 <20150608224749.GB7557@n2100.arm.linux.org.uk>
 <CALszF6DPzhAufUyWW-a3X7Cp4=tjSyCBM=Y4LcnWnUH=41qeoQ@mail.gmail.com>
 <5576D0FE.10900@linaro.org>
Message-ID: <CALszF6B7G7uMPB0BMYVDvUnsqqzSO85w-iU61JT0xDmkm0uqfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

2015-06-09 13:41 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
> On 09/06/15 10:14, Maxime Coquelin wrote:
>>>
>>> The real solution is to provide a definition _in asm-generic_ for
>>> arch_irqs_disabled(), rather than having almost every arch doing:
>>>
>>> static inline bool arch_irqs_disabled(void)
>>> {
>>>          return arch_irqs_disabled_flags(arch_local_save_flags());
>>> }
>>>
>>> I'm personally refusing to take a patch for ARM which adds yet another
>>> copy of the above.  This is, after all, exactly the kind of stuff that
>>> should be in asm-generic, or if not, in include/linux but overridable
>>> by arch stuff.
>>>
>>> We keep going between the two extremes of "lets push lots of stuff into
>>> arch stuff" and "lets try to extract the common bits out of arch code".
>>>
>>> Let's try and settle on one approach, and apply it universally.

>
> Does the following patch, which makes the arch_irqs_disabled()
> implementation from asm-generic available on arm, fix the build for you?

I confirm it fixes the build on Russell's for-next branch with efm32_defconfig.
I have no efm32 HW to test it though.

>
> I've only done a real quick 'n dirty check for regression:
> multi_v7_defconfig still works ;-)
>
> If the patch is useful I can test it a bit harder...

I can also test it this evening with my stm32 config.

Thanks,
Maxime
