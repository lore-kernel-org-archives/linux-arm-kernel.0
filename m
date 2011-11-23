From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Nov 2011 11:19:19 -0800
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
In-Reply-To: <20111123190954.GA4365@opensource.wolfsonmicro.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <20111122154900.GB18954@kroah.com>
 <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
 <20111122191347.GB4844@kroah.com>
 <20111123165903.GF31337@atomide.com>
 <20111123180651.GB19739@n2100.arm.linux.org.uk>
 <20111123185518.GG31337@atomide.com>
 <20111123190954.GA4365@opensource.wolfsonmicro.com>
Message-ID: <20111123191919.GH31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown <broonie@opensource.wolfsonmicro.com> [111123 10:34]:
> On Wed, Nov 23, 2011 at 10:55:19AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [111123 09:31]:
> 
> > > Keep the clk API as a fundamental thing which should be initialized early
> > > so we don't have to invent new clk APIs to get around its unavailability.
> 
> > What else are you aware of that is really needed early for clocks other
> > than clockevent?
> 
> If nothing else we'd have to resolve all the device probe ordering
> issues (Grant's patches seem a bit stalled) and convert all the systems
> using the API to handle deferring probes until their clocks appear.
> Using an early initcall of some kind would help with that but it does
> seem like a lot of trouble and I'd expect it'll end up getting forced in
> on most systems anyway.

Yes the ordering depends on the system. In any case, initcalls are
not super early compared to setup_timer.

Tony
