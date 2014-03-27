From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 27 Mar 2014 13:38:23 +0100
Subject: [PATCH v3] ata: fix Marvell SATA driver dependencies
In-Reply-To: <1668037.2oe7J2B7N4@amdc1032>
References: <1668037.2oe7J2B7N4@amdc1032>
Message-ID: <20140327123823.GM25349@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 01:23:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Make sata_mv host driver depend on PCI || ARCH_DOVE || ARCH_KIRKWOOD ||
> ARCH_MV78XX0 || ARCH_MVEBU || ARCH_ORION5X config options as Marvell
> SATA support covers both Marvell PCI devices and Marvell Dove, Kirkwood,
> MV78xx0, Armada 370/XP and Orion5x SoCs (for non-PCI devices the driver
> to work requires suitable device tree node to be defined).

Good old fashioned platform driver will also work. In fact, 95% of Orion5x
and mv78xx0 devices don't have DT yet.

You might also be able to simplify it to

PCI || PLAT_ORION || COMPILE_TEST

But i suggest you build test to make sure.

    Andrew
