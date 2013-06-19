From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 19 Jun 2013 10:53:48 -0600
Subject: [PATCH v3 11/12] ARM: mvebu: Relocate Armada 370 PCIe device
 tree nodes
In-Reply-To: <201306191411.59010.arnd@arndb.de>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306182335.50722.arnd@arndb.de>
 <20130619111257.GD16138@localhost>
 <201306191411.59010.arnd@arndb.de>
Message-ID: <20130619165348.GA32155@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 02:11:58PM +0200, Arnd Bergmann wrote:

> > Mmm.. and why is this option acceptable?
> 
> As I explained on IRC, there is no requirement to pick a specific bus
> aperture. The only two sensible choices are to make the bus address
> the same as the CPU address, or to make the bus address start at 0,
> which is what this does.

PCI bus addresses must not alias other addresess in the system or
you'll get weirdness. For instance DMA initiated from the PCI bus at
address 0, intended to read from SDRAM at 0 must not be claimed by
another device on the PCI bus. IMHO, a 1:1 mapping between PCI and CPU
is strongly preferred. Any other configuration will need some
additional techniques to avoid aliasing.

Jason
