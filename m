From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 19 May 2015 12:04:33 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <555B07D0.4030000@aksignal.cz>
References: <55559D55.6020703@aksignal.cz> <20150515172516.005e3a21@bbrezillon>
 <5559865F.9010502@aksignal.cz> <20150518092750.449d6c8c@bbrezillon>
 <5559A029.9060007@aksignal.cz> <555AA8F1.80100@atmel.com>
 <20150519091442.675b1a98@bbrezillon> <555AFBFD.3010506@aksignal.cz>
 <20150519111402.747e8eb2@bbrezillon> <555B07D0.4030000@aksignal.cz>
Message-ID: <20150519120433.763a416e@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 May 2015 11:52:16 +0200
Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:

> 
> 
> On 19.5.2015 11:14, Boris Brezillon wrote:
> >
> > There's a difference between your heartbeat (the frequency you
> > refresh/reset your watchdog) and the watchdog expiration time (here set
> > to 16 secs).
> > We usually set the heartbeat to 1/2 or 1/4 the expiration time, so that
> > we're (almost) sure we can reset the watchdog before its expiration.
> >
> >
> I'm confused. Why need kernel to know the time in witch userspace process will reset watchdog?

This time is not exposed to userspace, it's the internal heartbeat used
by the driver to refresh the watchdog.

> And how to change watchdog expiration time?

With the atmel,max-heartbeat-sec property.

Anyway, that does not explain why your system takes 61 secs to trigger
a reset (instead of 16 secs).
Can you try to revert this commit [1] ?


[1]https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/drivers/watchdog/at91sam9_wdt.c?id=d677772e1358924bf487cd833bdc4d50f3f6f64d
-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
