From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Nov 2013 11:45:48 +0000
Subject: [PATCH v5 1/4] ARM: deprecate mach/timex.h for !ARCH_MULTIPLATFORM
In-Reply-To: <201311051234.43321.arnd@arndb.de>
References: <20131105083336.GK14892@pengutronix.de>
 <1383642757-9762-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdacQhwccK8nKf7m5aTA9ciHPuWth11v-OVPo0kS9WcUCQ@mail.gmail.com>
 <201311051234.43321.arnd@arndb.de>
Message-ID: <20131105114548.GQ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 12:34:42PM +0100, Arnd Bergmann wrote:
> config CLOCK_TICK_RATE
> 	int
> 	depends on !ARCH_MULTIPLATFORM && ARCH_USES_GETTIMEOFFSET
> 	depends on ARCH_GEMINI || ARCH_SA1100 || ARCH_EBSA110 || ARCH_EP93XX || ARCH_RPC || ARCH_AT91X40
> 	default 40000000 if ARCH_AT91X40
> 	default 38000000 if ARCH_GEMINI
> 	default 3686400 if ARCH_SA1100
> 	default 47894000 if ARCH_EBSA110
> 	default 983040 if ARCH_EP93xx
> 	default 2000000 if ARCH_RPC
> 	# don't even think about adding more to this list, better get rid of the
> 	# existing ones by converting them to proper clocksources

That's a pipedream.  It really is.  Some of those are impossible to
convert because you don't have enough timers/counters to provide the
clocksource and clockevents - as I've mentioned several times in the
past.

clocksource and clockevents are all very nice and such, but they don't
always fit real hardware.
