From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jun 2011 10:21:38 +0200
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <4DFB5656.2060000@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<BANLkTinSuce1SQkjKva+DoUVRoJrQjU10Q@mail.gmail.com>
	<4DFB5656.2060000@arm.com>
Message-ID: <BANLkTikRiXOf257-ekha=yHE1iVmSC5gYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2011 at 3:27 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> [Me]
>> I would like to test on U8500 and also rebase Colins TWD
>> CPUfreq patch on top of this so it can go in on top of the
>> consolidations.
>
> I've created a new repository on git.kernel.org:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> and rebased my stuff on top of -rc3 in the "local_timer_devices" branch.

I pulled it into my tree and booted on U8500, and it works
like a charm. The GIC PPI stuff seems to be working too
atleast from looking in /proc/interrupts:

689:        933          0   GIC-PPI  arm_smp_twd
692:          0        434   GIC-PPI  arm_smp_twd
IPI0:          0          0  Timer broadcast interrupts
IPI1:        586        695  Rescheduling interrupts
IPI2:          0          0  Function call interrupts
IPI3:          4          5  Single function call interrupts
IPI4:          0          0  CPU stop interrupts

So:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

For the general stuff and the Ux500 patch.

Thanks,
Linus Walleij
