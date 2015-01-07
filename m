From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Jan 2015 17:22:14 +0100
Subject: [PATCH 4/4] dma: X-Gene PCIE DMA Driver
In-Reply-To: <CAL-zptNW81KwWXnMcsh_S5KQFMNGysm=ATmixMge6RXj_U-_zQ@mail.gmail.com>
References: <1420608537-12296-1-git-send-email-mchitale@apm.com>
 <9430055.pMHRTP0RMA@wuerfel>
 <CAL-zptNW81KwWXnMcsh_S5KQFMNGysm=ATmixMge6RXj_U-_zQ@mail.gmail.com>
Message-ID: <1765004.TVkcxIlmTg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 21:35:22 Mayuresh Chitale wrote:
> >
> > I think I'm missing something important here. What exactly is the
> > interaction with PCI here? Is it possible to use the dmaengine
> > driver at all when the PCI host controller is not in endpoint mode?
> Yes. Dmaengine driver can be used when port is configured as RC or EP.
> >
> > Does the dmaengine show up as a PCI device when the PCI controller is
> > in host mode?
> No. It sits between AXI and PCI interfaces but it needs to be
> programmed via the config bar.

Ok, I see. So in RC mode, it sounds like this is a regular DMA engine
that could be used with arbitrary slaves, but in EP mode it would
actually be controlled by the remote host, right?

When we are in RC mode, who sets up that BAR? If this is set up by
the firmware, we can just have the register appear in the DT as well,
as it's known, and when we are in EP mode, it sounds like we would
not even use the dmaengine because it's owned by the other host.

Or is there a way that in EP mode, both sides would access the
dma engine simultaneously?

	Arnd
