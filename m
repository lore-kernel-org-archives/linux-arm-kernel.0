From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Sep 2009 21:01:17 +0100
Subject: calls to notify_die missing -> ftrace_dump_on_oops non-functional
In-Reply-To: <20090913195543.GA9104@pengutronix.de>
References: <20090912195454.GA32429@pengutronix.de>
	<20090912213648.GA18424@n2100.arm.linux.org.uk>
	<20090913195543.GA9104@pengutronix.de>
Message-ID: <20090913200117.GA30169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2009 at 09:55:44PM +0200, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> On Sat, Sep 12, 2009 at 10:36:48PM +0100, Russell King - ARM Linux wrote:
> > On Sat, Sep 12, 2009 at 09:54:54PM +0200, Uwe Kleine-K?nig wrote:
> > > Dying on ARM looks quite different to dying on x86.  Russell, what's
> > > your position here?  Would you accept a patch that makes them more
> > > similar?
> > 
> > The position is that I got tired of chasing x86 in this area, and
> > we've got what was the most correct implementation that I could come
> > up with.  We do quite a number of things differently from x86,
> > including providing as complete as possible siginfo stuff everywhere
> > possible.
> > 
> > So, here's a patch which does an overall update to the ARM die()
> > implementation, including adding the notify support, kexec support
> > and loglevel stuff to printks.
> There are still a few printks without loglevel.  Is this intended?
> Just looking at the patch, I think it's good.  I will test it for a
> while in my tree.  Thanks.

Getting them into the backtrace isn't easy atm - that's also used for
printing stuff other than just the oops, and we currently have no easy
way to provide the log level to it.  Eg, we wouldn't want things like
the task debug backtraces to be printed at EMERG level.
