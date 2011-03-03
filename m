From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 3 Mar 2011 11:02:06 +0100
Subject: [PATCH] ARM: imx: move selection between i.MX21 and i.MX27 to
	CPU family choice
In-Reply-To: <20110303052653.GA19961@b20223-02.ap.freescale.net>
References: <20110302112559.GC22310@pengutronix.de>
	<1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110303052653.GA19961@b20223-02.ap.freescale.net>
Message-ID: <20110303100206.GP22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Thu, Mar 03, 2011 at 01:26:54PM +0800, Richard Zhao wrote:
> On Wed, Mar 02, 2011 at 06:23:05PM +0100, Uwe Kleine-K?nig wrote:
> > The only use of selecting MX2-based before was to get the choice to select
> > between i.MX21 and i.MX27. So better provide this choice directly.
> > 
> > Note that this has an influence on reduced i.MX21 configs because the
> > former default "MACH_MX21" for the "CPUs" choice makes MACH_MX21 not
> > appear in the reduced config and so the default for "Freescale CPU family:"
> > (i.e. ARCH_MX3) is used now.  mx21_defconfig is adapted not to be affected
> > by this problem.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> > -config ARCH_MX2
> > -	bool "MX2-based"
> > +config MACH_MX21
> > +	bool "MX21-based"
> > +	select ARCH_MX2
> >  	help
> > -	  This enables support for systems based on the Freescale i.MX2 family
> > +	  This enables support for systems based on the Freescale i.MX21 family
> Is it ToDo marker like ARCH_51? Why is it MACH_xx while others are ARCH_XX?
this is done to keep existing code working. MACH_MX21 and MACH_MX27 are
used in drivers/.

> It might be little strange that mx2x is a excetion while others are grouped.
This is good, it might make people aware that there is still work to do.
:-)  After the first steps for a multi-SoC-kernel are done, the grouping
has to change anyhow and doesn't match cpu families anymore. Moreover
MX2 is (IMHO) a marketing name, e.g. because i.MX25 is too different
compared to i.MX21 and i.MX27. And note that i.MX25 had a seperat entry
already before.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
