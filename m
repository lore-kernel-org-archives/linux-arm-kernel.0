From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Sun, 22 Aug 2010 17:03:43 -0400
Subject: [PATCH for -tip 1/2] kernel.h: add
	MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2
In-Reply-To: <AANLkTingCD78PYQN1f-0jNQYAU1v6W5RXHe73FnpmqDA@mail.gmail.com>
References: <20100821141750.770348530@efficios.com>
	<20100821142215.023431313@efficios.com>
	<20100822192705.GE1771@one.firstfloor.org>
	<20100822193819.GA23299@Krystal>
	<AANLkTingCD78PYQN1f-0jNQYAU1v6W5RXHe73FnpmqDA@mail.gmail.com>
Message-ID: <20100822210342.GA21755@Krystal>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Anca Emanuel (anca.emanuel at gmail.com) wrote:
> I think about some test at the last bit if it is on, the number is not
> a power of 2

Can you give an example, along with the types you have in mind ?

Thanks,

Mathieu

> 
> On Sun, Aug 22, 2010 at 10:38 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > * Andi Kleen (andi at firstfloor.org) wrote:
> >> > +/* Force a compilation error if condition is constant and not a power of 2 */
> >> > +#define MAYBE_BUILD_BUG_ON_NOT_POWER_OF_2(n) ? ? ? ? ? ? ? \
> >> > + ? MAYBE_BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
> >>
> >> Looks super-ugly. IMHO just writing MAYBE_BUILD_BUG_ON(!n || n & (n - 1)) directly
> >> would be clear enough. If you really think that's unclear define a generic
> >> is_power_of_two() macro.
> >
> > There is already a is_power_of_two macro in log2.h, but I fear it might
> > incorrectly interact with "MAYBE_BUILD_BUG_ON" (for some reason passing the
> > constant result of a static inline is not treated as a constant by the macro,
> > and thus it always "passes" the test).
> >
> > So if everyone object to this new macro, I'd be tempted to just go with your
> > suggestion. However the fact that we already have BUILD_BUG_ON_NOT_POWER_OF_2(n)
> > made me think that some people prefer to have it done as a macro.
> >
> > Other opinions ?
> >
> > Thanks,
> >
> > Mathieu
> >
> >
> > --
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at ?http://www.tux.org/lkml/
> >

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
