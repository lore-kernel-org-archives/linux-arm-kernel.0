From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 7 Feb 2014 11:27:56 -0700
Subject: [PATCH 19/21] ARM: MVEBU: Simplifiy headers and make local
In-Reply-To: <20140207093104.7197224d@skate>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-20-git-send-email-andrew@lunn.ch>
 <20140207093104.7197224d@skate>
Message-ID: <20140207182756.GF16263@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +#define KIRKWOOD_REGS_PHYS_BASE	0xf1000000
> > +#define DDR_PHYS_BASE           (KIRKWOOD_REGS_PHYS_BASE + 0x00000)
> > +#define BRIDGE_PHYS_BASE	(KIRKWOOD_REGS_PHYS_BASE + 0x20000)

Sorry I missed this earlier, but it would be *super nice* if
KIRKWOOD_REGS_PHYS_BASE could go away. 0xf1000000 is an arbitary
policy choice and with the mbus driver this is the last hold out.

That said, it could be revised after your series. :)

Regards,
Jason
