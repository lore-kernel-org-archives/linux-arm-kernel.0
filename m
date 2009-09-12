From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 12 Sep 2009 21:54:54 +0200
Subject: calls to notify_die missing -> ftrace_dump_on_oops non-functional
Message-ID: <20090912195454.GA32429@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I noticed yesterday that ARM doesn't call notify_die (added in

	1eeb66a (move die notifier handling to common code)

).

As ftrace_dump_on_oops depends on this function being called I don't get
an ftrace dump in my oopses.

Locally I added

	notify_die(DIE_OOPS, str, regs, err, current->thread.trap_no, SIGSEGV);

at the end of __die() in arch/arm/kernel/traps.c but I think this is not
completely correct because---assuming I understood it
correctly---notify_die returning NOTIFY_STOP should stop the process
dying.  Christoph, is this correct?

Dying on ARM looks quite different to dying on x86.  Russell, what's
your position here?  Would you accept a patch that makes them more
similar?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
