From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 26 Mar 2014 17:23:02 +0100
Subject: [PATCH] ata: fix Marvell SATA driver dependencies
In-Reply-To: <5138028.BSQbEP7RRB@amdc1032>
References: <5138028.BSQbEP7RRB@amdc1032>
Message-ID: <20140326162302.GG25349@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 05:19:02PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Make sata_mv host driver depend on PCI || ARCH_KIRKWOOD || ARCH_MVEBU ||
> ARCH_ORION5X config options as Marvell SATA support covers both Marvell
> PCI devices and Marvell Kirkwood, Armada 370/XP and Orion5x SoCs (for
> non-PCI devices the driver to work requires suitable device tree node to
> be defined).  Additionally allow the driver build if COMPILE_TEST config
> option is set.

Hi Bartlomiej

I _think_ there are a few powerpc platforms which can also make use of
this driver.

     Andrew
