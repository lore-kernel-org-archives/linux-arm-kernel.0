From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Nov 2013 10:42:48 +0100
Subject: [PATCH v5 1/4] ARM: deprecate mach/timex.h for !ARCH_MULTIPLATFORM
In-Reply-To: <1383642757-9762-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20131105083336.GK14892@pengutronix.de>
 <1383642757-9762-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdacQhwccK8nKf7m5aTA9ciHPuWth11v-OVPo0kS9WcUCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 10:12 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> +config NEED_MACH_TIMEX_H
> +       bool
> +       help
> +         Select this when mach/timex.h is required to provide special
> +         definitions for this platform. This should be avoided when possible.

OK this is no blocker, and do proceed with this as the kernel sure
looks better after this than before it.

However as the next step I would prefer that we start to get rid of
all the NEED_MACH_FOO_H used for just refactoring out headers.

Can we not completely do away with this header next, and provide
the services it supplied locally in the mach-foo folder for these machines
instead so we do not need to have all these Kconfig things and preserve
the <mach/*> namespace for them?

The real trick is to make CLOCK_TICK_RATE and LATCH runtime
variables instead of a compile-time variables, right? Can't we do
this?

Yours,
Linus Walleij
