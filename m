From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 06 Mar 2014 18:39:15 +0100
Subject: [PATCH v2 2/6] PCI: tegra: use new OF interrupt mapping when
 possible
In-Reply-To: <5318B232.2020507@wwwdotorg.org>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-3-git-send-email-l.stach@pengutronix.de>
 <5318B232.2020507@wwwdotorg.org>
Message-ID: <1394127555.4582.1.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 06.03.2014, 10:36 -0700 schrieb Stephen Warren:
> On 03/05/2014 06:25 AM, Lucas Stach wrote:
> > This is the recommended method of doing the IRQ
> > mapping. For old devicetrees we fall back to the
> > previous practice.
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> I tested both with and without patch 1/6, and the PCIe-based NIC on
> Beaver worked fine either way. Without patch 1/6, I do see:
> 
> pci 0000:00:01.0: of_irq_parse_pci() failed with rc=-22
> 
> ... but that seems reasonable given that the DT that of_irq_parse_pci()
> parses is missing, and did correctly trigger the fallback path, so
> everything still worked.

Yes, this should be normal. It spits this error for old DTs, but keeps
doing the right thing. I'm not sure if we should downgrade this to info
or dbg.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
