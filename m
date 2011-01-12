From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 12 Jan 2011 11:57:50 +0100 (CET)
Subject: BUG: spinlock recursion (sys_chdir, user_path_at, do_path_lookup
	...)
In-Reply-To: <20110112075229.GZ24920@pengutronix.de>
References: <20110111110539.GP24920@pengutronix.de>
	<20110112075229.GZ24920@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1101121153370.12146@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jan 2011, Uwe Kleine-K?nig wrote:
> > [   75.280000]  r5:be961ee4 r4:00063015
> > 
> > I started to bisect, but already the first test case showed a different
> > error (my getty dying every few seconds).
> I bisected this one now, the first bad commit is
> 
> 	9c0729d (x86: Eliminate bp argument from the stack tracing routines)
> 
> .  It made a x86 specific change to include/linux/stacktrace.h.

As I said on IRC already, that's complete nonsense. The commit changes
a function prototype which is only relevant for x86. So how should
that affect ARM ?

> According to tglx the lockup above "is related to nicks scalability
> stuff".  I havn't researched yet the offending commit.  Is that
> necessary?

Only if you are interested that the problem gets fixed.

Thanks,

	tglx
