From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Mar 2013 17:37:28 +0100
Subject: [PATCH 2/2] ARM: clk: imx35 sound admux_gate bugfix
In-Reply-To: <20130327155011.GY18316@opensource.wolfsonmicro.com>
References: <1364383352-27267-1-git-send-email-mpa@pengutronix.de>
 <1364383352-27267-3-git-send-email-mpa@pengutronix.de>
 <1364385420.5442.12.camel@pizza.hi.pengutronix.de>
 <20130327123659.GT18316@opensource.wolfsonmicro.com>
 <20130327150420.GB6347@pengutronix.de>
 <20130327155011.GY18316@opensource.wolfsonmicro.com>
Message-ID: <20130327163728.GE6347@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 03:50:11PM +0000, Mark Brown wrote:
> On Wed, Mar 27, 2013 at 04:04:20PM +0100, Markus Pargmann wrote:
> > On Wed, Mar 27, 2013 at 12:37:00PM +0000, Mark Brown wrote:
> 
> > > This is a patch to the ASoC driver?  I just ignored it since it said it
> > > was an ARM patch...  Anyway, what I'd expect should be happening here is
> > > that the clock API walks up the tree enabling supply clocks - that would
> > > mean that either that code isn't there or there's a missing parent child
> > > relationship in the data.
> 
> > It changes some things in imx-ssi, sorry, perhaps I should have
> > splitted it into two patches.
> 
> > admux clock does not seem to be a physical parent of the ssi clock, so
> > I don't think it should be a parent in the clock tree. But imx-ssi (or
> > some other evice) needs this clock to work. As mentioned in the other
> > response, I will put it directly into clk-imx35.c so this won't be a
> > patch for ASoC in the next version.
> 
> If it's the IP that needs the clock then I'd expect the IP to be
> requesting it so changing the driver does make sense.  Do we actually
> know what the clock does?

No we don't know exactly. imx35 reference manual does not give any
further explanation about admux. But I just found this old patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-November/003843.html

So I tested to register admux as audmux clock for imx-audmux, which
seems to solve the problem. However, I am not sure why the old patch
of Sascha was not applied.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
