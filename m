From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Jun 2013 17:12:28 +0200
Subject: [PATCH 3/3] ARM: integrator: pciv3: do not remap IO so early
In-Reply-To: <20130626081409.GC2718@n2100.arm.linux.org.uk>
References: <1372201560-26015-1-git-send-email-linus.walleij@linaro.org>
 <20130626081409.GC2718@n2100.arm.linux.org.uk>
Message-ID: <201306261712.28981.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Russell King - ARM Linux wrote:
> On Wed, Jun 26, 2013 at 01:06:00AM +0200, Linus Walleij wrote:
> > Instead of remapping the IO memory very early with
> > pci_map_io_early(), use pci_ioremap_io() when setting
> > up resources as most PCI bridges do. Also request this
> > resource properly.
> 
> What impact does this have with a VGA card plugged in?

It probably won't work. It's my fault for misreading the driver:
I saw it didn't do the pci_ioremap_io, but didn't remember the
*_early call being present in the platform.

	Arnd
