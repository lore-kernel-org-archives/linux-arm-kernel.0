From: marex@denx.de (Marek Vasut)
Date: Wed, 4 Jul 2012 02:13:04 +0200
Subject: MX28 poweroff issue
In-Reply-To: <20120703224609.GC26355@n2100.arm.linux.org.uk>
References: <201207040030.36713.marex@denx.de>
 <20120703224609.GC26355@n2100.arm.linux.org.uk>
Message-ID: <201207040213.04758.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King - ARM Linux,

> On Wed, Jul 04, 2012 at 12:30:36AM +0200, Marek Vasut wrote:
> > I recently confirmed this issue when doing "poweroff". The issue was
> > initially reported by Detlev Zundel.
> 
> My guess is it's because we don't disable interrupts on halt - because
> the kernel used to allow halt followed by another ctrl-alt-reboot to
> cause the thing to reboot.

This I consider correct.

> That's long since gone, so we might as well make the CPU spin endlessly
> waiting for someone to pull the power on halt...

The backtrace signals the problem being caused by timer interrupt. Maybe the 
struct sys_timer shall be extended by .exit callback to shut down the timer?

Well, the other option is to disable interrupts, indeed.

Russell, you're the wiser one, therefore shall I submit a patch-attempt that 
disables interrupts before the spinning?

Best regards,
Marek Vasut
