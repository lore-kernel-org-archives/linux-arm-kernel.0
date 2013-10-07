From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Oct 2013 10:51:18 -0700
Subject: [PATCH] ARM: integrator: deactivate timer0 on the Integrator/CP
In-Reply-To: <1381151993-5450-1-git-send-email-linus.walleij@linaro.org>
References: <1381151993-5450-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131007175118.GC17592@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 03:19:53PM +0200, Linus Walleij wrote:
> This fixes a long-standing Integrator/CP regression from
> commit 870e2928cf3368ca9b06bc925d0027b0a56bcd8e
> "ARM: integrator-cp: convert use CLKSRC_OF for timer init"
> 
> When this code was introduced, the both aliases pointing the
> system to use timer1 as primary (clocksource) and timer2
> as secondary (clockevent) was ignored, and the system would
> simply use the first two timers found as clocksource and
> clockevent.
> 
> However this made the system timeline accelerate by a
> factor x25, as it turns out that the way the clocking
> actually works (totally undocumented and found after some
> trial-and-error) is that timer0 runs @ 25MHz and timer1
> and timer2 runs @ 1MHz. Presumably this divider setting
> is a boot-on default and configurable albeit the way to
> configure it is not documented.
> 
> So as a quick fix to the problem, let's mark timer0 as
> disabled, so the code will chose timer1 and timer2 as it
> used to.
> 
> This also deletes the two aliases for the primary and
> secondary timer as they have been superceded by the
> auto-selection
> 
> Cc: stable at vger.kernel.org
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: can you please apply this directly for fixes
> if noone complains? Thanks.

Certainly, but I'll give them a day or two to complain. Prod me if I haven't
applied by Wednesday (and there has been no further discussion).


-Olof
