From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jun 2013 09:14:09 +0100
Subject: [PATCH 3/3] ARM: integrator: pciv3: do not remap IO so early
In-Reply-To: <1372201560-26015-1-git-send-email-linus.walleij@linaro.org>
References: <1372201560-26015-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130626081409.GC2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 01:06:00AM +0200, Linus Walleij wrote:
> Instead of remapping the IO memory very early with
> pci_map_io_early(), use pci_ioremap_io() when setting
> up resources as most PCI bridges do. Also request this
> resource properly.

What impact does this have with a VGA card plugged in?
