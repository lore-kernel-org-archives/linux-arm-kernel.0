From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 2 Jan 2010 14:56:09 +0100
Subject: 32-rc1 aka 32-rc2: warning at manage.c:361 (set_irq_wake),
	matrix-keypad related?
In-Reply-To: <20091203031709.GE9121@core.coreip.homeip.net>
References: <20090930200746.GA1384@ucw.cz>
	<20091006050649.GH27881@core.coreip.homeip.net>
	<20091006075816.GA1362@ucw.cz>
	<20091007043603.GC10204@core.coreip.homeip.net>
	<f17812d70910070742y5e27f9c3u38e3299b94f33613@mail.gmail.com>
	<20091007163327.GA12053@core.coreip.homeip.net>
	<20091007211225.GB17805@elf.ucw.cz>
	<20091203031709.GE9121@core.coreip.homeip.net>
Message-ID: <20100102135608.GA5872@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > We ignore the failure right now in the mainline but that causes stack
> > > traces on resume as we trying to disable not enabled wakeup GPIOs. That
> > > was original Pavel's complaint.
> > 
> > Yep...
> > 
> > I'd say that BUG() simply should not trigger if wakeup can not be
> > enabled/disabled for particular source...?
> 
> Pavel,
> 
> Could you please try the patch below and let me know if it fixes the
> problem for you?

(sorry for long delay).

With 33-rc1+your patch, warnings are no longer there. 

I still have one on irq191, but that's gpio button driver.

But please, hold the patch for few more days. I may have cleaner/nicer
solution. It seems that zaurus is doing something very stupid in low layers.

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
