From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 2 Aug 2013 10:16:13 +0200
Subject: [RFC 2/8] gpio: mxc: Support for initialization as submodule
In-Reply-To: <20130730093741.GG12382@S2101-09.ap.freescale.net>
References: <1374938808-27316-1-git-send-email-mpa@pengutronix.de>
 <1374938808-27316-3-git-send-email-mpa@pengutronix.de>
 <20130730034354.GF19715@S2101-09.ap.freescale.net>
 <20130730083929.GI16871@s25.your-server.de>
 <20130730093741.GG12382@S2101-09.ap.freescale.net>
Message-ID: <20130802081613.GT16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 05:37:43PM +0800, Shawn Guo wrote:
> On Tue, Jul 30, 2013 at 10:39:29AM +0200, Markus Pargmann wrote:
> > > > +	if (pdata) {
> > > > +		port->base = pdata->base;
> > > > +		iores = NULL;
> > > 
> > > Why is this needed?
> > 
> > The memory regions used for iomux control overlap the regions used by
> > the gpio driver. So we need to share the memory with the pinctrl driver.
> 
> I meant for iores = NULL;

Not necessary, I removed it.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
