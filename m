From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Nov 2013 12:37:50 +0100
Subject: [PATCH v5 1/4] ARM: deprecate mach/timex.h for !ARCH_MULTIPLATFORM
In-Reply-To: <201311051234.43321.arnd@arndb.de>
References: <20131105083336.GK14892@pengutronix.de>
 <1383642757-9762-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdacQhwccK8nKf7m5aTA9ciHPuWth11v-OVPo0kS9WcUCQ@mail.gmail.com>
 <201311051234.43321.arnd@arndb.de>
Message-ID: <CACRpkdYNYzw4CAd-bROZnLAyiAuMKq+1pmUKaS-LO8oEQ0qJLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 12:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Maybe we can collapse the CLOCK_TICK_RATE into a single Kconfig symbol
> like
>
> asm/timex.h:
>
> #ifdef CONFIG_CLOCK_TICK_RATE
> #define CLOCK_TICK_RATE CONFIG_CLOCK_TICK_RATE
> #endif
> /* EOF */
>
> Kconfig:
>
> config CLOCK_TICK_RATE
>         int
>         depends on !ARCH_MULTIPLATFORM && ARCH_USES_GETTIMEOFFSET
>         depends on ARCH_GEMINI || ARCH_SA1100 || ARCH_EBSA110 || ARCH_EP93XX || ARCH_RPC || ARCH_AT91X40
>         default 40000000 if ARCH_AT91X40
>         default 38000000 if ARCH_GEMINI
>         default 3686400 if ARCH_SA1100
>         default 47894000 if ARCH_EBSA110
>         default 983040 if ARCH_EP93xx
>         default 2000000 if ARCH_RPC
>         # don't even think about adding more to this list, better get rid of the
>         # existing ones by converting them to proper clocksources

+1 for this approach, since we already use this pattern for
other things.

Yours,
Linus Walleij
