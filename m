From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 8 Sep 2015 18:12:12 +0200
Subject: at91sam9 Main crystal frequency problems
In-Reply-To: <55ED3D3B.8060700@overkiz.com>
References: <55ED3D3B.8060700@overkiz.com>
Message-ID: <20150908181212.0b4336f0@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Mon, 7 Sep 2015 09:31:07 +0200
Antoine Aubert <a.aubert@overkiz.com> wrote:

> Hi,
> 
> I currently bring up a board based on AT91SAM9G25cu, and I having
> problems of watchdogs resets.
> 
> We use linux-4.04 mainline, and i found some weird warnings on kernel
> traces, concerning main clk.
> 
> [    0.000000] Main crystal frequency not set, using approximate value
> [    0.000000] master clk is overclocked
> [    0.000000] sched_clock: 32 bits at 128 Hz, resolution 7812500ns,
> wraps every 16777216000000000ns
> [    0.007812] Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)
> 
> I set crystal clock in the DT, but it doesn't seems to work.. I feel
> that the board works out of the specified range.

According to your clk_summary dump that's not the case.

> 
> So here comes my questions:
> Can there be a relationship with watchdog problems ? (1 per day)

I'd say no, but could you tell me more about your watchdog issues.

> Why is it that the frequency of Crystal is not found ?

That's a good question, and honestly I don't. Everything seems to be
defined properly in your device tree.

Could you add some traces in the fixed-rate clk driver [1] to see if the
main_xtal is correctly registered and if its registration occurs before
the main_osc registration?

Best Regards,

Boris

[1]https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/drivers/clk/clk-fixed-rate.c?id=refs/tags/v4.0.4#n115

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
