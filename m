From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 May 2011 08:46:44 -0700
Subject: [PATCH 1/4] drivers: create a pinmux subsystem
In-Reply-To: <BANLkTimrGP1ohGX1B4teaNMbgVjSb5Mw5Q@mail.gmail.com>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
	<20110504091619.GV2092@atomide.com>
	<BANLkTimrGP1ohGX1B4teaNMbgVjSb5Mw5Q@mail.gmail.com>
Message-ID: <20110509154644.GE11410@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mike Rapoport <mike.rapoport@gmail.com> [110507 12:07]:
> On Wed, May 4, 2011 at 12:16 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Linus Walleij <linus.walleij@stericsson.com> [110502 12:13]:
> >
> > Good to see this, looks like this should work for omaps too.
> >
> > The numbering solves the issue where we have multiple
> > pinmux domains (base + offset for each domain).
> >
> > Then I would assume that for most cases the pin access can be
> > described with:
> >
> > unsigned long pinmux_base; ? ? ?/* Can have multiple pinux domains */
> > u16 pinmux_reg_offset; ? ? ? ? ?/* Register offset from pinmux_base */
> > u16 flags; ? ? ? ? ? ? ? ? ? ? ?/* Register width etc */
> >
> > Which can be accessed with read[bwl] and write[bwl], so we
> > can have default access functions in the pinux framework and
> > don't necessarily have to implement them for each platform.
> 
> On some platforms setting the pin configuration won't require to keep
> that lot of data, see, e.g. Orion and it's successors.

Yeah but if we can figure out some common data format the wasted
memory won't matter compared to having common code.

I guess if we plan on passing the mux registers in devicetree data,
we actually should just have something like this for each mux entry: 

address
muxmodes
flags

Don't know how well that would work for tegra, can you calculate
the configuration registers from some base address maybe?

Regards,

Tony
