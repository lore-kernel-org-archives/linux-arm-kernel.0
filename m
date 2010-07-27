From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 28 Jul 2010 01:16:07 +0200
Subject: [PATCH] [ARM] VIC: Remove resume_sources
In-Reply-To: <1276144595-17411-1-git-send-email-jy0922.shim@samsung.com>
References: <1276144595-17411-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <AANLkTiniACNQvLYGMiD43zUaRykMEjsFEigOSseUm33D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/10 Joonyoung Shim <jy0922.shim@samsung.com>:

> The resume_sources is the bitmask of interrupts allowed for resume
> sources, but it's value is zero in the all machine using VIC then
> vic_set_wake returns always error.

In the U300 I actually set it to 1, not 0, for all available interrupt
lines. The idea is that any IRQ shall wake the system. I don't
think it matters much tho.

> The interrupt sources to allow can use to resume sources too and
> vic_set_wake called by set_irq_wake desides whether enable or disable
> interrupt sources to resume sources, so we don't have any reason to
> control resume sources by resume_sources.
>
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>

That makes sense so:
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
