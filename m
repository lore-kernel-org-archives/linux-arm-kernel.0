From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 1 Nov 2009 23:03:41 +0100
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091101213343.GA31345@elf.ucw.cz>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
	<20091101205449.GT14091@buzzloop.caiaq.de>
	<20091101213343.GA31345@elf.ucw.cz>
Message-ID: <20091101220341.GA16698@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi!
> 
> > > Is anyone using suspend/resume with a recent git mainline kernel on PXA
> > > or other ARM embedded boards? My platform used to suspend and resume
> > > just fine on 2.6.31 but now as I rebased it, it fails the resume part.
> > > 
> > > Unfortunately, I can't bisect it as the platform is not mainline yet and
> > > so I always have mandatory patches (without my platform won't do
> > > anything) on top of the git repository. Which breaks the bisect logic.
> > > 
> > > What puzzles me is that I see the current raising at wakeup time, so at
> > > least the processor seems to resume, but I can't see any serial console
> > > output, just like if the kernel crashed very early after wakeup.
> > > 'no_console_suspend' didn't help either.
> > 
> > Ok, got it. The culprit is commit d2c37068 ("[ARM] pxa: initialize
> > default interrupt priority and use ICHP for IRQ handling"). Reverting it
> > make suspend/resume work again on my board.
> > 
> > Haojian, Eric, could you have a look at this?
> 
> Okay, patch is this one: I'll test reverting it shortly.
> 
> commit d2c37068429b29d6549cf3486fc84b836689e122
> Author: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date:   Wed Aug 19 19:49:31 2009 +0800
> 
>     [ARM] pxa: initialize default interrupt priority and use ICHP for IRQ handling
>     
>     Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

And yes, reverting it _does_ fix suspend on spitz.

									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
