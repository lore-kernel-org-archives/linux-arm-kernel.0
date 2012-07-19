From: marex@denx.de (Marek Vasut)
Date: Thu, 19 Jul 2012 19:04:30 +0200
Subject: MX28 poweroff issue
In-Reply-To: <20470.38021.796461.625280@ipc1.ka-ro>
References: <201207040030.36713.marex@denx.de>
 <20120705201002.GB31508@n2100.arm.linux.org.uk>
 <20470.38021.796461.625280@ipc1.ka-ro>
Message-ID: <201207191904.31000.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lothar Wa?mann,

> Hi,
> 
> Russell King - ARM Linux writes:
> > On Fri, Jul 06, 2012 at 12:08:58AM +0800, Shawn Guo wrote:
> > > On Wed, Jul 04, 2012 at 04:19:44PM +0100, Russell King - ARM Linux wrote:
> > > > If it's specific to mx28 and mx23 and nothing else, the cause needs
> > > > to be found.  Maybe we need it tested on other (non-MX) platforms
> > > > too?
> > > 
> > > Though people reported that imx27 does not have the problem, I'm not
> > > so sure about it's a mach-mxs (mx23 and mx28) specific issue.  I have
> > > not figured it out why imx27 does not run into it, but I got some
> > > finding here.
> > > 
> > > Let's look at the dump again.
> > > 
> > > [   59.840000] System halted.
> > > [   84.100000] BUG: soft lockup - CPU#0 stuck for 23s! [halt:584]
> > > ...
> > > [   84.100000] [<c0070cd4>] (watchdog_timer_fn+0x114/0x14c) from
> > > [<c004052c>] (__run_hrtimer+0x7c/0x1ec)
> > > 
> > > It reports the issue eventually in function watchdog_timer_fn
> > 
> > > (kernel/watchdog.c):
> > Yes, the general idea is that if the timer is running, and the watchdog
> > is running, and it detects that it's event thread doesn't occasionally
> > run, it will report a lockup.
> > 
> > As other platforms seem to not exhibit the problem when we halt, and
> > endlessly spin with IRQs enabled, the question needs to be asked: what
> > is different with MX23/MX28 and why is it different.
> 
> I could reproduce this on an i.MX53 (TX53) platform too. Maybe the
> softlockup watchdog was not enabled on those platforms which didn't
> show this behaviour.

So what's the result, where did this discussion lead to?

Best regards,
Marek Vasut
