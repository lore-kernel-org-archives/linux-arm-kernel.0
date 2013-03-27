From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Mar 2013 15:50:11 +0000
Subject: [PATCH 2/2] ARM: clk: imx35 sound admux_gate bugfix
In-Reply-To: <20130327150420.GB6347@pengutronix.de>
References: <1364383352-27267-1-git-send-email-mpa@pengutronix.de>
 <1364383352-27267-3-git-send-email-mpa@pengutronix.de>
 <1364385420.5442.12.camel@pizza.hi.pengutronix.de>
 <20130327123659.GT18316@opensource.wolfsonmicro.com>
 <20130327150420.GB6347@pengutronix.de>
Message-ID: <20130327155011.GY18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 04:04:20PM +0100, Markus Pargmann wrote:
> On Wed, Mar 27, 2013 at 12:37:00PM +0000, Mark Brown wrote:

> > This is a patch to the ASoC driver?  I just ignored it since it said it
> > was an ARM patch...  Anyway, what I'd expect should be happening here is
> > that the clock API walks up the tree enabling supply clocks - that would
> > mean that either that code isn't there or there's a missing parent child
> > relationship in the data.

> It changes some things in imx-ssi, sorry, perhaps I should have
> splitted it into two patches.

> admux clock does not seem to be a physical parent of the ssi clock, so
> I don't think it should be a parent in the clock tree. But imx-ssi (or
> some other evice) needs this clock to work. As mentioned in the other
> response, I will put it directly into clk-imx35.c so this won't be a
> patch for ASoC in the next version.

If it's the IP that needs the clock then I'd expect the IP to be
requesting it so changing the driver does make sense.  Do we actually
know what the clock does?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/3ed7a7e1/attachment.sig>
