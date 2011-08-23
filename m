From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 23:13:14 +0100
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <CAOS58YNuCbaOsWBfmjSUsXsArZ5ng6c0B30yswFbRAWkho6L6Q@mail.gmail.com>
References: <20110823151936.GM9232@opensource.wolfsonmicro.com>
	<201108232351.55432.rjw@sisk.pl>
	<CAOS58YNUSn2eVLDLzqKmrtL7M5tSetkhZ1ODecLK54NSDnZVAA@mail.gmail.com>
	<20110823220056.GK3895@n2100.arm.linux.org.uk>
	<CAOS58YNuCbaOsWBfmjSUsXsArZ5ng6c0B30yswFbRAWkho6L6Q@mail.gmail.com>
Message-ID: <20110823221314.GL3895@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 12:08:23AM +0200, Tejun Heo wrote:
> On Wed, Aug 24, 2011 at 12:00 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > How does that solve it? ?IRQs disabled from assembly, which doesn't touch
> > the preempt counter.
> 
> Then test something else, be it the IRQ mask bit or some other context.

Thereby entirely preventing threads from being frozen?  You're asking
me to effectively disable suspend/resume on an architecture where it's
heavily used.  That's not a good idea, and would be an out-right
regression.
