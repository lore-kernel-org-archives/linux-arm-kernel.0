From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 21 Nov 2012 10:33:05 -0700
Subject: [PATCH] ARM: Kirkwood: Use hw_pci.ops instead of hw_pci.scan
In-Reply-To: <20121121090231.GT10259@lunn.ch>
References: <20121121071511.GE19837@obsidianresearch.com>
 <20121121090231.GT10259@lunn.ch>
Message-ID: <20121121173304.GB6406@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 10:02:31AM +0100, Andrew Lunn wrote:
> On Wed, Nov 21, 2012 at 12:15:11AM -0700, Jason Gunthorpe wrote:
> > The kirkwood_pcie_scan_bus function duplicates the common code in
> > bios32.c, passing ops in will use the common code..
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> >  arch/arm/mach-kirkwood/pcie.c |   18 +-----------------
> >  1 files changed, 1 insertions(+), 17 deletions(-)
> > 
> > Just a little clean up I found while reviewing the PCI-E code.
> 
> Hi Jason
> 
> Have you tested this on a kirkwood platform? Its hard for me to test,
> i don't have a kirkwood with a used PICE slot.

Yes, I have a system that uses the PCI-E.

CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
Kirkwood: MV88F6282-Rev-A1, TCLK=200000000.
PCI: bus0 uses PCIe port 0
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
pci_bus 0000:00: root bus resource [io  0x1000-0xffff]
pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
pci 0000:00:00.0: [11ab:6282] type 00 class 0x058000
pci 0000:00:00.0: reg 10: [mem 0xf1000000-0xf10fffff]
pci 0000:00:00.0: reg 18: [mem 0x00000000-0x07ffffff]
pci 0000:00:00.0: supports D1 D2
PCI: bus0: Fast back to back transfers disabled
pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
pci 0000:00:01.0: [170c:0001] type 00 class 0x058000
pci 0000:00:01.0: reg 10: [mem 0x00000000-0x0000ffff]
pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
pci 0000:00:01.0: BAR 0: assigned [mem 0xe0000000-0xe000ffff]
PCI: enabling device 0000:00:01.0 (0000 -> 0002)

Jason
