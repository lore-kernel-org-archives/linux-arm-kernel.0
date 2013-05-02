From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 18:21:11 +0200
Subject: [PATCH 1/7] ARM: u300: push down syscon registers
In-Reply-To: <1367511416-4312-2-git-send-email-linus.walleij@stericsson.com>
References: <1367511416-4312-1-git-send-email-linus.walleij@stericsson.com>
 <1367511416-4312-2-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201305021821.12008.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Get rid of the <mach/syscon.h> header as a prerequisite for
> multiplatform support. Do this by pushing the registers down
> to their respective drivers and deleting the unused remainder.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Mike: I'm seeking an ACK for this to take it through the
> ARM SoC tree alongside the big bowl of DT enablement patches.
> ---

How do those drivers get to the SYSCON base address? Should they
be using drivers/mfd/syscon.c as the multiplexor instead?

	Arnd
