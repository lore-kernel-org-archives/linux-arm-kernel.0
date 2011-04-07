From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 Apr 2011 09:38:39 +0200
Subject: [RFC] filter function for submaintainers
In-Reply-To: <1302141606.20777.34.camel@pororo>
References: <20110404161716.GG13963@pengutronix.de>
	<20110404170049.GA12200@pengutronix.de>
	<20110404170515.GF7285@pengutronix.de>
	<20110406190313.GA767@pengutronix.de>
	<20110406193416.GB767@pengutronix.de>
	<1302141606.20777.34.camel@pororo>
Message-ID: <20110407073839.GE13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jeremy,

On Thu, Apr 07, 2011 at 10:00:06AM +0800, Jeremy Kerr wrote:
> > The problem (admittedly only from a quick glance at
> > patchwork.ozlabs.org) I see is that it's not possible to reliably filter
> > patches by directory name. (Or maybe I'm just to stupid to find the
> > right knob, I tried searching for "drivers/net/ehea" in the netdev
> > project, got a few hits, but e.g.
> > http://patchwork.ozlabs.org/patch/89837/ wasn't listed. My guess is that
> > the search only checks subject and commit log?)
> 
> At present, the search only covers the patch subject.
> 
> > For us I think this is a crucial function, because the imx patches are
> > usually sent to the linux-arm-kernel mailing list where most patches
> > don't touch the files we are responsible for.
> 
> It sounds like a separate linux-imx patchwork instance would suit better
> - this would mean you don't have to constantly apply filters to get the
> patches that you're interested in.
"constantly apply filters" could be a "view" saved in the settings.
Something like:

	<a href="...">all incoming patches</a>
	<a href="...">imx patches<a/>

on project/$project/list/, and in the settings something like

	views:
		- all
		- imx
			                    ,------------------------------------.
			files/dirs touched: | arch/arm/{plat-mxc,mach-{imx,mx*}} |
			                    `------------------------------------'
			maybe some more criterias?

	default view: O all , X imx

together with a "New view" button.

> I'm very happy to set up a patchwork instance on ozlabs.org for you; but
> (as you've mentioned) we'd need to filter-out the imx patches from the
> rest of the l-a-k content that you're not interested in tracking.
> 
> Most projects (eg linux-davinci, linux-omap) do this by using a separate
> mailing list; I assume you'd rather keep your patches on the main ARM
> list, correct?
*I* don't consider it sensible to have a seperate mailing list, I'd
expect Sascha to agree. And in fact we already have such a list, because
a mail sent to Sascha's email address listed in the MAINTAINERS file
ends in the mailboxes of all developers at Pengutronix.

> Since this is a one-off, I think an external program to filter relevant
> patches from l-a-k would be best. This would check the diffstat for
> interesting paths, then conditionally feed the patch to the patchwork
> parser.
> 
> Would this suit? Are you OK with including patches that are not
> necessarily imx-specific, but touch imx-related code (eg,
> architecture-wide code cleanups)?
That would be great. And yes, I'd want to include all patches that touch
arch/arm/{plat-mxc,mach-{imx,mx*}}.

But please don't invest too much effort here. We didn't use patchwork up
to know. I expect it will ease our workflow but as we're not 100% sure,
I'd have a bad conscience if you had a big effort and we say in 2 months
it doesn't help us much.
So if that's easier for you, just egreping the body instead of the
diffstat is enough (and probably produces an equivalent result most of
the time).

Something like the following (assuming you use procmail) should be fine:

	:0 B
	* arch/arm/(plat-mxc|mach-(imx|mx[^/]*))/
	| don't know you action line

should be fine.

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
