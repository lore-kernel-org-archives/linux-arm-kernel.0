From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 3 Jan 2014 11:44:24 -0700
Subject: Issue with the emulated PCI bridge implementation
In-Reply-To: <201401031322.31433.arnd@arndb.de>
References: <20131226160534.36cc4203@skate> <20131226165241.2c50b244@skate>
 <20140103002656.GA12098@obsidianresearch.com>
 <201401031322.31433.arnd@arndb.de>
Message-ID: <20140103184424.GC12098@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 01:22:31PM +0100, Arnd Bergmann wrote:

> However the part that made me wonder is that an e1000e with a PCI bridge
> actually /should/not/ need to allocate an I/O space window with a precious
> mbus resource, since AFAIK this adapter does not have an I/O space BARs.

IIRC the e1000 still has a legacy IO port BAR.. (guessing it is used
for PXE boot on x86?)

My patch set to allow the DT to turn off IO port allocation is already
in mainline - drop the IO ranges from the DT and no IO resources are
consumed at all.

Though, that is an interesting point, a small refinement would be to
not allocate the pci io map if IO is turned off as well..

Jason
