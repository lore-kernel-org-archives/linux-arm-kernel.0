From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Mar 2014 01:25:28 +0100
Subject: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
In-Reply-To: <1394127555.4582.1.camel@weser.hi.pengutronix.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <5318B232.2020507@wwwdotorg.org>
 <1394127555.4582.1.camel@weser.hi.pengutronix.de>
Message-ID: <201403070125.28582.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 March 2014, Lucas Stach wrote:
> Am Donnerstag, den 06.03.2014, 10:36 -0700 schrieb Stephen Warren:
> > On 03/05/2014 06:25 AM, Lucas Stach wrote:
> > > This is the recommended method of doing the IRQ
> > > mapping. For old devicetrees we fall back to the
> > > previous practice.
> > 
> > Tested-by: Stephen Warren <swarren@nvidia.com>
> > 
> > I tested both with and without patch 1/6, and the PCIe-based NIC on
> > Beaver worked fine either way. Without patch 1/6, I do see:
> > 
> > pci 0000:00:01.0: of_irq_parse_pci() failed with rc=-22
> > 
> > ... but that seems reasonable given that the DT that of_irq_parse_pci()
> > parses is missing, and did correctly trigger the fallback path, so
> > everything still worked.
> 
> Yes, this should be normal. It spits this error for old DTs, but keeps
> doing the right thing. I'm not sure if we should downgrade this to info
> or dbg.

No, I think printing an error like this is appropriate: it is an incentive
to update the dts files, but doesn't look too urgent as long as everything
still works.

	Arnd
