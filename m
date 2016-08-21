From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sun, 21 Aug 2016 03:21:47 -0400
Subject: [PATCH RFC] Revert "of/irq: Mark initialised interrupt
 controllers as populated"
In-Reply-To: <CAL_JsqKpLGscFaCT4x3NtQCOBgLK+-MQa_XDmpmkqyepdJVT4Q@mail.gmail.com>
References: <E1bYVVh-0001eq-BI@rmk-PC.armlinux.org.uk>
 <CAL_JsqJNE7rGaL54HfmGEkaScZ7krf_iM55UrKw6mwWdLHv6Ow@mail.gmail.com>
 <CABxcv=n9o7sU0zB3WZ2Sp8Aqd+fnv1KLp8UcAx2YSrKBVW+rhg@mail.gmail.com>
 <CAL_JsqKpLGscFaCT4x3NtQCOBgLK+-MQa_XDmpmkqyepdJVT4Q@mail.gmail.com>
Message-ID: <CABxcv=nU4P-XfR6PcY_wrXTe09GyLADP5h==86G2v8GQmHLW4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob,

On Sat, Aug 20, 2016 at 4:18 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Sat, Aug 20, 2016 at 10:18 AM, Javier Martinez Canillas
> <javier@dowhile0.org> wrote:

[snip]

>>
>> I noticed that Philipp also sent a patch to clear that flag in
>> arch/arm/mach-imx/gpc.c [1]. I guess the same is needed in the drivers
>> for the devices that are not created for Exynos?
>
> Yes, you need the same.
>

Great, thanks a lot for the confirmation.

>> If that's the case, then I think that's more safe to revert Jon's
>> commit for now since is too risky for the -rc cycle and more platforms
>> may be affected.
>
> I prefer not to and find the affected platforms. I've now grepped the

Ok, at the end I found that the only problem was with the Exynos PMU
driver since both IRQCHIP_DECLARE() and a platform driver is used for
the interrupt and PMU (Power Management Unit) controller
functionalities respectively. I'll post a patch for that.

> tree to get all the IRQCHIP_DECLARE compatible strings and then
> grepped for other occurrences and didn't find any more. In theory, we
> could have matching happening with 2 different strings, but I'd guess
> that is unlikely.
>
> Rob

Best regards,
Javier
