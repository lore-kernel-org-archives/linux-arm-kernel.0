From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 30 Aug 2012 21:57:48 +0400
Subject: [PATCH] ARM: clps711x: convert to clocksource/clockevents
In-Reply-To: <CACRpkdYHenkDYnZ5W8xzR58ioK8=8-rfSQFrtpTqfGYy28-cSA@mail.gmail.com>
References: <1346344678-18248-1-git-send-email-linus.walleij@linaro.org>
 <20120830210210.55e0899d.shc_work@mail.ru>
 <CACRpkdYHenkDYnZ5W8xzR58ioK8=8-rfSQFrtpTqfGYy28-cSA@mail.gmail.com>
Message-ID: <20120830215748.492ce5e3.shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2012 10:21:44 -0700
Linus Walleij <linus.walleij@linaro.org> wrote:

> >> This converts the ageing clps711x timer driver to the modern
> >> clocksource/clockevent API.
> > The patch does not account for the changes that I sent to the mailing list
> > recently, where I did support different clock frequencies for the processor.
> No problem, I can rebase on top of your patches as soon as you
> submit them to ARM SoC so I can see them in linux-next.
Patches have already been sent to the mailing list, and as far I understand,
these patches are awaiting approval from Arnd.

...
> > The patch uses a second timer, which does not allow its use for other purposes, 
> What does this mean? Reading the datasheet it didn't say anything about
> this timer being dedicated to something else.
> I am using TC1D as clocksource and TC2D as clockevent, repurposing
> it from the previous use as singe time source.
> Doing "git grep TC1D" I cannot see any code in the kernel making use
> of this timer?
These timers are only two in the processor and I just want to say that the second
timer CAN be used for other purposes, such as I use. In the kernel of the second
timer is really not used.

> I could think of things like the boot loader or firmware setting it up
> to run in free-running mode ... in that case we use
> it as clocksource without initialization as long as we know what
> frequency it's running on.
Not understand this...

> As far as I could understand from the datasheet there is really
> no way to actually disable these timers, so they always run
> anyway?
Yes. We can only enable/disable IRQ for the timers, switch clock source and mode.

> > I have also tried to do something like this without using additional processor
> > resources, but not yet brought to the finish line yet.
> OK do you think you can switch the clps71x over to generic time and
> clockevents inspired by this patch or so?
Unfortunately, I'm leaving tomorrow for a little while so I can not check anything
or try to do better, but the idea of ??switching to a new API I like. Upon arrival back,
I'll try to make a similar using only one timer or use the CLOCKSOURCE/CLOCKEVENTS
resources to generate intervals necessary for me.

-- 
Alexander Shiyan <shc_work@mail.ru>
