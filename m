From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Mar 2013 16:03:02 +0000
Subject: [PATCH V7 1/2] ARM: bcm281xx: Add timer driver (driver portion)
In-Reply-To: <alpine.LFD.2.02.1303140951580.22263@ionos>
References: <1363210048-3334-1-git-send-email-csd@broadcom.com>
 <51410BF4.4040400@linaro.org> <alpine.LFD.2.02.1303140951580.22263@ionos>
Message-ID: <201303141603.02401.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 March 2013, Thomas Gleixner wrote:
> > But if its arch specific for hardware I don't have, I'd really prefer the arch
> > maintainer be the upstream path.
> > 
> > Thomas: Am I being too obstinate here?  If not, should we drop "F:
> > drivers/clocksource" from the MAINTAINERS entry?

The idea of moving drivers out of arch/* into drivers/* is definitely to
have someone who understands the subsystem act as the gatekeeper. There
should be very little architecture specific knowledge in those drivers,
and I think it's more important to ensure that they are following a
sensible understanding of how timekeeping is done than that they
are following specific architecture maintainer's preferences.

> Maybe we should move the ARM specific ones into
> drivers/clocksource/arm/ ?

About half the IP blocks we use on ARM are also used on at least
one ARM64/AVR32/MIPS/PowerPC/x86/SH/Hexagon/c6x/etc part. Grouping them
by which CPU architecture first starts using them or happens to be
more popular at the time does not seem too helpful here.

Maybe it's better to have a subdirectory for those clock sources
that are used on any SoC, or have subdirectories based on the
company that created that part, as we do for ethernet drivers.
I wouldn't bother with that until there are a couple of dozen
different clock source drivers.

	Arnd
