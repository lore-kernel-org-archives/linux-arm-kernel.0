From: jk@ozlabs.org (Jeremy Kerr)
Date: Thu, 07 Apr 2011 10:00:06 +0800
Subject: [RFC] filter function for submaintainers
In-Reply-To: <20110406193416.GB767@pengutronix.de>
References: <20110404161716.GG13963@pengutronix.de>
	<20110404170049.GA12200@pengutronix.de>
	<20110404170515.GF7285@pengutronix.de>
	<20110406190313.GA767@pengutronix.de>
	<20110406193416.GB767@pengutronix.de>
Message-ID: <1302141606.20777.34.camel@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

> The problem (admittedly only from a quick glance at
> patchwork.ozlabs.org) I see is that it's not possible to reliably filter
> patches by directory name. (Or maybe I'm just to stupid to find the
> right knob, I tried searching for "drivers/net/ehea" in the netdev
> project, got a few hits, but e.g.
> http://patchwork.ozlabs.org/patch/89837/ wasn't listed. My guess is that
> the search only checks subject and commit log?)

At present, the search only covers the patch subject.

> For us I think this is a crucial function, because the imx patches are
> usually sent to the linux-arm-kernel mailing list where most patches
> don't touch the files we are responsible for.

It sounds like a separate linux-imx patchwork instance would suit better
- this would mean you don't have to constantly apply filters to get the
patches that you're interested in.

I'm very happy to set up a patchwork instance on ozlabs.org for you; but
(as you've mentioned) we'd need to filter-out the imx patches from the
rest of the l-a-k content that you're not interested in tracking.

Most projects (eg linux-davinci, linux-omap) do this by using a separate
mailing list; I assume you'd rather keep your patches on the main ARM
list, correct?

Since this is a one-off, I think an external program to filter relevant
patches from l-a-k would be best. This would check the diffstat for
interesting paths, then conditionally feed the patch to the patchwork
parser.

Would this suit? Are you OK with including patches that are not
necessarily imx-specific, but touch imx-related code (eg,
architecture-wide code cleanups)?

Cheers,


Jeremy
