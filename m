From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 13 Dec 2010 08:57:38 +0100
Subject: [PATCH v5 07/15] ARM: mxs: Add gpio support
In-Reply-To: <20101213072743.GA23558@ubuntu.localdomain>
References: <1291968402-19393-1-git-send-email-shawn.guo@freescale.com>
	<1291968402-19393-2-git-send-email-shawn.guo@freescale.com>
	<20101210102416.GH17441@pengutronix.de>
	<20101213072743.GA23558@ubuntu.localdomain>
Message-ID: <20101213075738.GA26210@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Dec 13, 2010 at 03:28:14PM +0800, Shawn Guo wrote:
> On Fri, Dec 10, 2010 at 03:24:16AM -0700, Uwe Kleine-K?nig wrote:
> > On Fri, Dec 10, 2010 at 04:06:40PM +0800, Shawn Guo wrote:
> > > +		__raw_writel(~0, port[i].base +
> > > +				PINCTRL_IRQSTAT(i) + MXS_CLR_ADDR);
> > Why not __raw_writel(0, port[i].base + PINCTRL_IRQSTAT(i)) ?
> > (And note that applying ~ on a signed integer isn't portable in
> > general.  For all sane archs this is the same as ~0U though and ARM is
> > sane (here), still I think it's good to be aware of such things and
> > avoid them if easily possible.)
> > 
> The i.MX28 RM section 9.4.78 tells "Software may clear any bit in this
> register by writing a 1 to the bit at the SCT clear address".
I didn't say that __raw_writel(~0,  ... + MXS_CLR_ADDR) didn't work.
It's just that I consider writing a 0 directly into the PINCTRL_IRQSTAT
register a bit more clear.
 
> What about writing 0xffffffff into clear address?
If you insist on doing that, at least write ~0U which is more portable.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
