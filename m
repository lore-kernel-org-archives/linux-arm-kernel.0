From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Sun, 22 Aug 2010 15:38:20 -0400
Subject: [PATCH for -tip 1/2] kernel.h: add
	MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2
In-Reply-To: <20100822192705.GE1771@one.firstfloor.org>
References: <20100821141750.770348530@efficios.com>
	<20100821142215.023431313@efficios.com>
	<20100822192705.GE1771@one.firstfloor.org>
Message-ID: <20100822193819.GA23299@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andi Kleen (andi at firstfloor.org) wrote:
> > +/* Force a compilation error if condition is constant and not a power of 2 */
> > +#define MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2(n)		\
> > +	MAYBE_BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
> 
> Looks super-ugly. IMHO just writing MAYBE_BUILD_BUG_ON(!n || n & (n - 1)) directly
> would be clear enough. If you really think that's unclear define a generic
> is_power_of_two() macro.

There is already a is_power_of_two macro in log2.h, but I fear it might
incorrectly interact with "MAYBE_BUILD_BUG_ON" (for some reason passing the
constant result of a static inline is not treated as a constant by the macro,
and thus it always "passes" the test).

So if everyone object to this new macro, I'd be tempted to just go with your
suggestion. However the fact that we already have BUILD_BUG_ON_NOT_POWER_OF_2(n)
made me think that some people prefer to have it done as a macro.

Other opinions ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
