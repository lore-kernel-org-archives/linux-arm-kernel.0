From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 11 Mar 2013 12:23:39 -0600
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <513E1CBA.4040007@firmworks.com>
References: <20130308191227.GA6551@avionic-0098.mockup.avionic-design.de>
 <513A3F4F.2090501@firmworks.com>
 <20130308200245.GC29435@obsidianresearch.com>
 <513A7845.6040304@firmworks.com>
 <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311074615.GA6365@avionic-0098.mockup.avionic-design.de>
 <513E1CBA.4040007@firmworks.com>
Message-ID: <20130311182339.GB10992@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> (b) The discovery/enumeration code needs to access config space via
> pci_ops.  The root complex driver implements pci_ops based on a trivial
> parsing of ranges (omitting irrelevant details):
> 
> pci_op_read(devfn, pos) {
>    loop_over_ranges_entries {
>       if (to_devfn(ranges_entry.child) == devfn) {
>          return mmio_read(ranges_entry.parent + pos);
                            ^^^^^^^^^^^^^^^^^^^

This has to be converted through all enclosing node's ranges prior to
being used as a CPU address - the OF core has all the code to do this,
but a new entry point would be needed for this specific application...

Cheers,
Jason
