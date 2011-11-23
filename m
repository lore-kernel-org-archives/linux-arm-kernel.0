From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Nov 2011 10:55:19 -0800
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <20111123180651.GB19739@n2100.arm.linux.org.uk>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <20111122154900.GB18954@kroah.com>
 <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
 <20111122191347.GB4844@kroah.com>
 <20111123165903.GF31337@atomide.com>
 <20111123180651.GB19739@n2100.arm.linux.org.uk>
Message-ID: <20111123185518.GG31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111123 09:31]:
> On Wed, Nov 23, 2011 at 08:59:04AM -0800, Tony Lindgren wrote:
> > ..let's plan on getting rid of the early usage of clocks instead so
> > you don't have the issue of deferring stuff.
> 
> No - we have too many platforms already using them early to do a change
> like this - and to do such a change will force them to invent some other
> way.  That's just stupid.

Not necessarily for all the systems. For omap2+ we should be able to
boot the system initially with the perf counter as the clockevent and
32KiHz always running timer. Then a dmtimer using proper clockevent
driver could take over.
 
> Keep the clk API as a fundamental thing which should be initialized early
> so we don't have to invent new clk APIs to get around its unavailability.

What else are you aware of that is really needed early for clocks other
than clockevent?

We've already proven that SRAM init can be moved to happen later. The
optional debug serial port is already enabled by the bootloader.

Regards,

Tony
