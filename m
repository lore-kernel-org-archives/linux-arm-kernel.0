From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 Mar 2016 09:43:40 +0100
Subject: [PATCH 0/2] ARM: dts: shmobile: Correct interrupt type for ARM TWD
In-Reply-To: <20160322012849.GA14367@verge.net.au>
References: <1458296361-4468-1-git-send-email-geert+renesas@glider.be>
 <20160322012849.GA14367@verge.net.au>
Message-ID: <CAMuHMdXcew-NHGeb2x69CR4ZBeyf3hET3xtQYSkToSX9BD68uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tue, Mar 22, 2016 at 2:28 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Mar 18, 2016 at 11:19:19AM +0100, Geert Uytterhoeven wrote:
>> This patch series corrects the interrupt type for ARM TWD timers on
>> SH-Mobile AG5 and R-Car H1.
>>
>> The ARM TWD interrupt is a private peripheral interrupt (PPI), and per
>> the ARM GIC documentation, whether the type for PPIs can be set is
>> IMPLEMENTATION DEFINED.
>>
>> For SH-Mobile AG5 and R-Car H1 devices the PPI type cannot be set, and
>> so when we attempt to set the type for the ARM TWD interrupt it fails.
>> This has gone unnoticed because it fails silently, and because we cannot
>> re-configure the type it has had no impact. Nevertheless fix the type
>> for the TWD interrupt so that it matches the hardware configuration.
>>
>> This was exposed by Jon Hunter's "[PATCH 04/15] irqchip/gic: WARN if
>> setting the interrupt type fails" (https://lkml.org/lkml/2016/3/17/339),
>> which triggers:
>>
>>     WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-common.c:61 gic_configure_irq+0x64/0x7c()
>>
>> Other Renesas SoCs using private peripheral interrupts (R-Mobile APE6,
>> R-Car Gen2, and R-Car Gen3) seem to be fine.
>>
>> Based on patches by Jon Hunter for Tegra20/30 and OMAP4.
>
> Thanks for this. Do you think it would be best to queue these up
> for v4.7 or as fixes for v4.6?

I don't know if/when Jon's patch will go in, but he's tracking the fixes for
various SoCs, as we don't know yet how many are affected.

So I think it's basically up to you.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
