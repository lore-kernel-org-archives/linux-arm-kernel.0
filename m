From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Jun 2013 19:16:41 +0200
Subject: [PATCH v3 03/12] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130618191255.178d2f42@skate>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306181814.33941.arnd@arndb.de> <20130618191255.178d2f42@skate>
Message-ID: <201306181916.41378.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Thomas Petazzoni wrote:
> Dear Arnd Bergmann,
> 
> On Tue, 18 Jun 2013 18:14:33 +0200, Arnd Bergmann wrote:
> 
> > Using 0xffff0002 as a placeholder for the pcie translation is definitely
> > better than 0xffff0000 as you had before, but let me ask again in case
> > you missed it the last time (and sorry if I missed the answer):
> > 
> > Why not just put the actual translation here the way it happens for each
> > of the PCIe ports? With the definition here, the PCIe driver actually has no
> > way to figure out what settings the windows need to use!
> 
> Come on Arnd, this is something we have already discussed countless
> times with you.
> 
> We cannot define translations for each PCIe port because we don't
> know in advance how much I/O and memory space each PCIe device will
> request. This is the reason why we have one global range for I/O
> space and one global space for memory space, that are given to the
> Linux PCI core, which then dynamically assigns sub-ranges for each
> PCIe device into those two global ranges.

Could you just stop assuming that I'm an idiot and read my suggestion?

The information that this puts into the device-tree is not where things
are mapped by how things are connected in hardware. The mbus mapping
is the part that is variable, while the PCI mapping is actually fixed
in hardware.

	Arnd
