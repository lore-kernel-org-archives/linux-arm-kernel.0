From: bhelgaas@google.com (Bjorn Helgaas)
Date: Fri, 4 Apr 2014 11:03:41 -0600
Subject: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping
 when possible
In-Reply-To: <20140305184219.GA29903@obsidianresearch.com>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
 <20140305184219.GA29903@obsidianresearch.com>
Message-ID: <20140404170341.GG9007@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 11:42:19AM -0700, Jason Gunthorpe wrote:
> On Wed, Mar 05, 2014 at 02:25:51PM +0100, Lucas Stach wrote:
> > -	return pp->irq;
> > +	irq = of_irq_parse_and_map_pci(dev, slot, pin);
> > +	if (!irq)
> > +		irq = pp->irq;
> 
> In light of the two bugs that Tim found, it might be wise to throw a
> 'dev_warn(FW_BUG "Missing DT interrupt mapping")' in the fall back
> path, so it doesn't continue to silently cover up errors on the OF/DT
> side..

This sounds like a reasonable thing to do, but I didn't see a response to
this comment.  Should I merge it as-is, or do you want to add the message?
