From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 4 Jan 2013 15:22:49 +0200
Subject: [PATCH 02/12] ARM: OMAP2+: PM: introduce power domains
 functional states
In-Reply-To: <CAORVsuXnbNLm3i=W2yb682qC1QH673nM3nPpNM_9OMds8SdzQA@mail.gmail.com>
References: <20121209174545.6933.59371.stgit@dusk.lan>
 <20121209175253.6933.87846.stgit@dusk.lan>
 <CAORVsuXnbNLm3i=W2yb682qC1QH673nM3nPpNM_9OMds8SdzQA@mail.gmail.com>
Message-ID: <1357305769.2221.81.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul / Jean,

On Wed, 2012-12-12 at 11:33 +0100, Jean Pihet wrote:

<clip>

> > +/**
> > + * _match_pwrst: determine the closest supported power state
> > + * @pwrsts: list of allowed states, defined as a bitmask
> > + * @pwrst: initial state to be used as a starting point
> > + * @min: minimum (i.e. lowest consumption) allowed state
> > + * @max: maximum (i.e. highest consumption) allowed state
> > + *
> > + * Search down then up for a valid state from a list of allowed
> > + * states.  Used by states conversion functions (_pwrdm_fpwrst_to_*)
> > + * to look for allowed power and logic states for a powerdomain.
> > + * Returns the matching allowed state.  XXX Deprecated.  The software
> > + * should not try to program unsupported powerstates.
> 
> 
> Why is this new code already deprecated? Does this require a rewrite?

Looks like it is removed by another patch in the same set and could
probably just be removed from this one also.

> > +       }
> > +
> > +       /* XXX deprecated */
> 
> 
> Same here

Same thing, maybe drop the code out completely.

-Tero
