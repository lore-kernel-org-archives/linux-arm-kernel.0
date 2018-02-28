From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Feb 2018 15:23:28 +0100
Subject: [PATCH] arm_pmu: Use disable_irq_nosync when disabling SPI in CPU
 teardown hook
In-Reply-To: <20180228135704.vuhk5mb6mqgc6jlr@lakrids.cambridge.arm.com>
References: <1519661456-30445-1-git-send-email-will.deacon@arm.com>
 <20180228135704.vuhk5mb6mqgc6jlr@lakrids.cambridge.arm.com>
Message-ID: <CAMuHMdWdua0+wsaMnkqRceOO=C5r23F-8jdnkwuR6kLBpUPb2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 2:57 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Feb 26, 2018 at 04:10:56PM +0000, Will Deacon wrote:
>> Commit 6de3f79112cc ("arm_pmu: explicitly enable/disable SPIs at hotplug")
>> moved all of the arm_pmu IRQ enable/disable calls to the CPU hotplug hooks,
>> regardless of whether they are implemented as PPIs or SPIs. This can
>> lead to us sleeping from atomic context due to disable_irq blocking:
>
>> Acked-by: Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> I think something went wrong here when you applied the tag. ;)

In case of respinning:
Fixes: 6de3f79112cc26bf ("arm_pmu: explicitly enable/disable SPIs at hotplug")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
