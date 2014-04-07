From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 07 Apr 2014 10:38:49 +0200
Subject: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping
 when possible
In-Reply-To: <20140404170517.GH9007@google.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
 <20140305184219.GA29903@obsidianresearch.com>
 <20140404170341.GG9007@google.com> <20140404170517.GH9007@google.com>
Message-ID: <1396859929.4553.2.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

Am Freitag, den 04.04.2014, 11:05 -0600 schrieb Bjorn Helgaas:
> On Fri, Apr 04, 2014 at 11:03:41AM -0600, Bjorn Helgaas wrote:
> > On Wed, Mar 05, 2014 at 11:42:19AM -0700, Jason Gunthorpe wrote:
> > > On Wed, Mar 05, 2014 at 02:25:51PM +0100, Lucas Stach wrote:
> > > > -	return pp->irq;
> > > > +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> > > > +	if (!irq)
> > > > +		irq = pp->irq;
> > > 
> > > In light of the two bugs that Tim found, it might be wise to throw a
> > > 'dev_warn(FW_BUG "Missing DT interrupt mapping")' in the fall back
> > > path, so it doesn't continue to silently cover up errors on the OF/DT
> > > side..
> > 
> > This sounds like a reasonable thing to do, but I didn't see a response to
> > this comment.  Should I merge it as-is, or do you want to add the message?
> 
> Oh, and I suppose the same question applies to the other host drivers in
> this series (tegra, rcar)?

Please apply as-is. of_irq_parse_and_map_pci() already prints an error
message if it isn't able to establish the mapping, thus right before we
fall into the fallback path. So any the warning would be redundant.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
