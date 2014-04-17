From: marex@denx.de (Marek Vasut)
Date: Thu, 17 Apr 2014 13:07:44 +0200
Subject: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
In-Reply-To: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <201404171307.44214.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 17, 2014 at 09:21:44 AM, Brian Norris wrote:
> Hi all,
> 
> We are introducing a new SPI-NOR library/framework for MTD, to support
> various types of SPI-NOR flash controllers which require (or benefit from)
> intimate knowledge of the flash interface, rather than just the relatively
> dumb SPI interface. This library borrows much of the m25p80 driver for its
> abstraction and moves this code into a spi-nor module.
> 
> This means CONFIG_M25P80 now has a dependency on CONFIG_MTD_SPI_NOR, which
> should be added to the defconfigs. I'm not sure what is the best process
> for doing this. Should each $ARCH maintainer just take their respective
> patch, even if the MTD_SPI_NOR Kconfig symbol is not defined for them yet?
> Or should maintainers plan on merging the relevant SPI-NOR code into their
> trees during the development cycle? Or some third option?

Shouldn't the M25P80 driver just "select" the SPI NOR framework? Then you won't 
need the adjustment to defconfigs at all I think.

Best regards,
Marek Vasut
