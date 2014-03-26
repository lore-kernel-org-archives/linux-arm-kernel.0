From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Wed, 26 Mar 2014 16:59:04 +0000
Subject: [PATCH] ata: fix Marvell SATA driver dependencies
In-Reply-To: <20140326162302.GG25349@lunn.ch>
References: <5138028.BSQbEP7RRB@amdc1032>
	<20140326162302.GG25349@lunn.ch>
Message-ID: <20140326165904.70de238d@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Mar 2014 17:23:02 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Wed, Mar 26, 2014 at 05:19:02PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Make sata_mv host driver depend on PCI || ARCH_KIRKWOOD || ARCH_MVEBU ||
> > ARCH_ORION5X config options as Marvell SATA support covers both Marvell
> > PCI devices and Marvell Kirkwood, Armada 370/XP and Orion5x SoCs (for
> > non-PCI devices the driver to work requires suitable device tree node to
> > be defined).  Additionally allow the driver build if COMPILE_TEST config
> > option is set.
> 
> Hi Bartlomiej
> 
> I _think_ there are a few powerpc platforms which can also make use of
> this driver

The hardware can show up in just about anything so I think this patch
should be dropped
