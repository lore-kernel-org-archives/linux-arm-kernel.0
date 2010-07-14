From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Jul 2010 17:20:49 +0100
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <20100714160941.GC1689@bnru01.bnr.st.com>
References: <20100713145645.GA24626@rakim.wolfsonmicro.main>
	<20100713150814.GA13767@bnru01.bnr.st.com>
	<20100713150905.GD24626@rakim.wolfsonmicro.main>
	<20100713161343.GA25342@bnru01.bnr.st.com>
	<20100713203852.GA1756@rakim.wolfsonmicro.main>
	<20100714145053.GA1689@bnru01.bnr.st.com>
	<20100714145748.GF31073@rakim.wolfsonmicro.main>
	<20100714153643.GB1689@bnru01.bnr.st.com>
	<20100714154726.GH31073@rakim.wolfsonmicro.main>
	<20100714160941.GC1689@bnru01.bnr.st.com>
Message-ID: <20100714162048.GA27512@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 09:39:42PM +0530, Sundar R IYER wrote:

> > For *all* supplies?

> Yes. whatever supplies I have listed here all can be enabled/disabled by
> their consumers. Sorry to ask, but please help me to understand the
> emphasis of the question. There are other supplies, which are controlled
> outside the kernel and so I haven't exposed them here.

Are you positive that in your system it is sensible for consumers to
enable and disable all the supplies?  Usually there are restrictions on
what can sensibly be done on a given system.  For example, disabling the
CPU core or RAM supplies from software would normally not work terribly
well.

> > some of the consumers on a shared supply are hooked up and doing enables
> > and disables, for example.  What happens when they cause the supply to
> > be disabled but another consumer is running?

> Again, sorry to ask(this is confusing :() - but isn't this managed by
> the core? It is the core's responsibility to effectively disable a
> supply when none of the consumers are using it; and to block a disable
> even when a single consumer is still using it.

Right, but think about the case I'm talking about: if you've only hooked
up some but not all of the consumers then the core has no idea about the
consumers you didn't hook up.  You can only do power control when *all*
the consumers needed are configured.
