From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Feb 2016 21:12:20 +0900
Subject: next-20160225 build: 2 failures 44 warnings (next-20160225)
In-Reply-To: <20160226091410.5dad4306@free-electrons.com>
References: <E1aYsmb-0006qb-76@optimist> <20160226030949.GL18327@sirena.org.uk>
 <20160226091410.5dad4306@free-electrons.com>
Message-ID: <20160226121220.GO18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 09:14:10AM +0100, Thomas Petazzoni wrote:

> atomic_io_modify() is also used in the ->start() and ->stop() hooks, so
> not only during initialization. The reason we use atomic_io_modify()
> here is because this TIMER_CTRL register is shared with the clocksource
> drivers (time-orion.c, time-armada-370-xp.c). Indeed, the timers and
> watchdogs share a single register that allows to enable/disable all
> timers/watchdogs. Somewhat unfortunate choice, but that's how the HW is.

> By far the easiest solution is to add "depends on ARM" to
> ORION_WATCHDOG.

> Another solution would be to provide an implementation of
> atomic_io_modify() on arm64, though that would need the ACK from the
> ARM64 maintainers.

It also sounds like a more modern solution might be to use syscon for
the shared register, but perhaps I'm missing something about how the IP
is set up so ICBW.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160226/c084c32b/attachment.sig>
