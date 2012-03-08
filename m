From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 8 Mar 2012 11:18:38 -0700 (MST)
Subject: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
In-Reply-To: <CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
 <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
 <CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1203081115010.9551@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Luciano,

On Thu, 8 Mar 2012, Coelho, Luciano wrote:

> I can't get ttyO2 wakeup to work on my Blaze with 3.3-rc5.  It works
> fine with 3.2.  I've been trying to bisect and everything, but it's
> difficult.  To start with, during my bisect, many patches seem to be
> in a state where the compilation fails (one example is
> 'OMAP44XX_IRQ_PRCM' undeclared).
> 
> Anyway, what I found out is that after fcf6efa3 (ARM: OMAP4: PM: Add
> WakeupGen module as OMAP gic_arch_extn) wakeup from the console
> doesn't work anymore for me.  Then I tried to comment out the
> omap_wakeupgen_init() call in  gic_init_irq() and that seems to
> work... for a while.  At least until ff819da4 (ARM: OMAP3: CPUidle:
> Make use of CPU PM notifiers) commenting out that line seems to work.
> But it doesn't work if I comment out the line with v3.3-rc5.

Maybe try this patch:

http://www.spinics.net/lists/linux-omap/msg65786.html

If that doesn't work, could you try to reproduce with omap2plus_defconfig 
and a boring kernel command line?


- Paul
