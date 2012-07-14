From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Jul 2012 07:57:39 +0000
Subject: [PATCH v2 00/15] PCI io.h clean-up
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <201207140757.40229.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 July 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This is the 2nd part of mach/io.h removals. This series removes io.h on
> platforms with PCI by creating a fixed virtual I/O mapping and a common
> __io() macro.
> 
> This version has changed a bit to accommodate Tegra converting its PCIe
> host to a platform driver. Now the virtual space is only reserved during
> early boot before .map_io() is called. The mapping is not created until
> calling pci_ioremap_io which can be done at any point after vmalloc is
> initialized.
> 
> I've gone back to fixed 64K windows for each PCI bus. This allows
> removing all the i/o resource setup from the individually platforms and
> placing it within the common ARM PCI code.
> 
> I've only tested versatilepb under qemu (with the model hacked up to
> actually enable i/o space), so any testing is appreciated. iop3xx and
> mv78xx0 have some risk of breaking as the PCI bus addresses are moved
> to 0 from matching the cpu host bus addesss.
> 
> This is available from my git tree:
> 
> git://sources.calxeda.com/kernel/linux.git io-cleanup-pci

I would propose sticking it in the arm-soc tree as a staging branch for
now to get some more testing on this. We can then decide in the merge
window if we consider it good enough or whether we want to delay it
to 3.7.

Any objections?

	Arnd
