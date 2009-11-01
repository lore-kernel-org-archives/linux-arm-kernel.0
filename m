From: daniel@caiaq.de (Daniel Mack)
Date: Sun, 1 Nov 2009 21:54:49 +0100
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20091031013427.GL14091@buzzloop.caiaq.de>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
Message-ID: <20091101205449.GT14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 31, 2009 at 02:34:27AM +0100, Daniel Mack wrote:
> Is anyone using suspend/resume with a recent git mainline kernel on PXA
> or other ARM embedded boards? My platform used to suspend and resume
> just fine on 2.6.31 but now as I rebased it, it fails the resume part.
> 
> Unfortunately, I can't bisect it as the platform is not mainline yet and
> so I always have mandatory patches (without my platform won't do
> anything) on top of the git repository. Which breaks the bisect logic.
> 
> What puzzles me is that I see the current raising at wakeup time, so at
> least the processor seems to resume, but I can't see any serial console
> output, just like if the kernel crashed very early after wakeup.
> 'no_console_suspend' didn't help either.

Ok, got it. The culprit is commit d2c37068 ("[ARM] pxa: initialize
default interrupt priority and use ICHP for IRQ handling"). Reverting it
make suspend/resume work again on my board.

Haojian, Eric, could you have a look at this?

Many thanks for all input, everyone :)

Thanks,
Daniel
