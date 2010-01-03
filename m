From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 3 Jan 2010 09:00:38 +0100
Subject: 32-rc1 aka 32-rc2: warning at manage.c:361 (set_irq_wake),
	matrix-keypad related?
In-Reply-To: <20100103075733.GA1358@core.coreip.homeip.net>
References: <20090930200746.GA1384@ucw.cz>
	<20091006050649.GH27881@core.coreip.homeip.net>
	<20091006075816.GA1362@ucw.cz>
	<20091007043603.GC10204@core.coreip.homeip.net>
	<f17812d70910070742y5e27f9c3u38e3299b94f33613@mail.gmail.com>
	<20091007163327.GA12053@core.coreip.homeip.net>
	<20091007211225.GB17805@elf.ucw.cz>
	<20091203031709.GE9121@core.coreip.homeip.net>
	<20100102135608.GA5872@ucw.cz>
	<20100103075733.GA1358@core.coreip.homeip.net>
Message-ID: <20100103080038.GA32383@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2010-01-02 23:57:33, Dmitry Torokhov wrote:
> On Sat, Jan 02, 2010 at 02:56:09PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > > We ignore the failure right now in the mainline but that causes stack
> > > > > traces on resume as we trying to disable not enabled wakeup GPIOs. That
> > > > > was original Pavel's complaint.
> > > > 
> > > > Yep...
> > > > 
> > > > I'd say that BUG() simply should not trigger if wakeup can not be
> > > > enabled/disabled for particular source...?
> > > 
> > > Pavel,
> > > 
> > > Could you please try the patch below and let me know if it fixes the
> > > problem for you?
> > 
> > (sorry for long delay).
> > 
> > With 33-rc1+your patch, warnings are no longer there. 
> > 
> 
> Thank you for testing.
> 
> > I still have one on irq191, but that's gpio button driver.
> > 
> > But please, hold the patch for few more days. I may have cleaner/nicer
> > solution. It seems that zaurus is doing something very stupid in low layers.
> 
> Sorry, it is already upstream. However I do think that the change is
> needed. As long as set_irq_wake() may return an error the driver should
> handle such error. Especially matrix_keypad that operates with large
> number of GPIOs but has only one knob for enabling wakeup.

Ok, no problem. I still get problems with gpio-button driver, but
there wakeup is per-button so... I'll just fix the wakeup handling on
zaurus.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
