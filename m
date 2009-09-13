From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 13 Sep 2009 21:55:44 +0200
Subject: calls to notify_die missing -> ftrace_dump_on_oops non-functional
In-Reply-To: <20090912213648.GA18424@n2100.arm.linux.org.uk>
References: <20090912195454.GA32429@pengutronix.de>
	<20090912213648.GA18424@n2100.arm.linux.org.uk>
Message-ID: <20090913195543.GA9104@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Sat, Sep 12, 2009 at 10:36:48PM +0100, Russell King - ARM Linux wrote:
> On Sat, Sep 12, 2009 at 09:54:54PM +0200, Uwe Kleine-K?nig wrote:
> > Dying on ARM looks quite different to dying on x86.  Russell, what's
> > your position here?  Would you accept a patch that makes them more
> > similar?
> 
> The position is that I got tired of chasing x86 in this area, and
> we've got what was the most correct implementation that I could come
> up with.  We do quite a number of things differently from x86,
> including providing as complete as possible siginfo stuff everywhere
> possible.
> 
> So, here's a patch which does an overall update to the ARM die()
> implementation, including adding the notify support, kexec support
> and loglevel stuff to printks.
There are still a few printks without loglevel.  Is this intended?
Just looking at the patch, I think it's good.  I will test it for a
while in my tree.  Thanks.
 
> I'm not entirely happy with this at present because it now means
> that die() can now return - this requires all callers to die() to
> be audited to ensure that they do something sane when die() does
> return.
I don't promise to have a look, but I will note it on my todolist.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
