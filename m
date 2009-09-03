From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 3 Sep 2009 22:15:21 +0200
Subject: [linux-pm] Montreal Linux Power Management Mini-Summit, July 13,
	2009 - Meeting Notes
In-Reply-To: <20090903171213.GB9507@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>
	<alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
	<63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
	<4A9E2EA7.8080700@st.com>
	<20090902215832.GB21292@n2100.arm.linux.org.uk>
	<4A9FD7C7.7070301@st.com>
	<20090903171213.GB9507@n2100.arm.linux.org.uk>
Message-ID: <63386a3d0909031315v77d2a2d0x490b15aa839f7339@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/9/3 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> [Francesco's blurb]
> ? The main goals are to manage:
> ? 1. each clock and the operations that the clock support
> ? 2. the clocks tree and the hierarchical relationships
> ? 3. the clock-device relationships
> ? 4. the clock rate change propagation
> ? 5. in an architecture independent way.

> Point 4 is something that OMAP might be able to use, though OMAP already
> does this within its clk API implementation without notification of
> drivers - the clock rates are driven by drivers requesting rates for
> their own clocks rather than one driver influencing the clock rate for
> another.
>
> That said, PXA could do with some notification of core state changes,
> which influences which clocks are available and the rate which they
> run at. ?It's something that is going to have some progress over the
> next year or so, and it could result in the clk API being extended
> with an optional API to support this.

We need something like (4) for U300 as well, we have the same
issue with core state propagating changes to several clocks, which
is mainly why I asked about this thing from the SuperH people.

> My biggest mistake, however, when designing the API was not to provide
> a standard (but optional) implementation for clk_get() and clk_put(),
> which I have now done with clkdev. ?(arch/arm/common/clkdev.c)

If other SoCs like SuperH (obviously) and maybe PowerPC, etc need this
as well, could it be relocated to something like drivers/clk and include/linux?
That sounds like fulfilling (5) for (3).

Linus Walleij
