From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Feb 2013 19:33:09 +0000
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130213180439.GB1601@obsidianresearch.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130213095701.0d9f9f20@skate> <20130213180439.GB1601@obsidianresearch.com>
Message-ID: <201302131933.09947.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 February 2013, Jason Gunthorpe wrote:
> > You seem to propose a global regs = <...> property under
> > pcie-controller, but indexing using marvell,pcie-port cannot work. PCIe
> > interfaces are identified by two values (port,lane), so we have 0.0,
> > 0.1, 0.2, 0.3, 1.0, 1.1, 1.2, 1.3, 2.0 and 3.0 on MV78460. I really
> > would like to avoid having bizarre computations to find which entry in
> > this big regs = <...> array correspond to a given PCIe interface.
> 
> Well, using the 'global' regs is an easy way to avoid the complexity with
> address translation and 'assigned-addresses'. So some way to translate
> between link # and regs index is necessary. How about using the PCI
> device number? Device number 1 is regs entry 0, 2 is regs entry 1, etc.

Or you could use the "reg-names" property.

	Arnd
