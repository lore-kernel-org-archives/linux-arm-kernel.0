From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Mar 2014 18:12:31 +0100
Subject: [PATCH] ata: fix Marvell SATA driver dependencies
In-Reply-To: <20140326165904.70de238d@alan.etchedpixels.co.uk>
References: <5138028.BSQbEP7RRB@amdc1032> <20140326162302.GG25349@lunn.ch>
 <20140326165904.70de238d@alan.etchedpixels.co.uk>
Message-ID: <4852939.9jMb8Bv2x2@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, March 26, 2014 04:59:04 PM One Thousand Gnomes wrote:
> On Wed, 26 Mar 2014 17:23:02 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > On Wed, Mar 26, 2014 at 05:19:02PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > Make sata_mv host driver depend on PCI || ARCH_KIRKWOOD || ARCH_MVEBU ||
> > > ARCH_ORION5X config options as Marvell SATA support covers both Marvell
> > > PCI devices and Marvell Kirkwood, Armada 370/XP and Orion5x SoCs (for
> > > non-PCI devices the driver to work requires suitable device tree node to
> > > be defined).  Additionally allow the driver build if COMPILE_TEST config
> > > option is set.
> > 
> > Hi Bartlomiej
> > 
> > I _think_ there are a few powerpc platforms which can also make use of
> > this driver
> 
> The hardware can show up in just about anything so I think this patch
> should be dropped

In theory maybe but in practice it for sure won't show up if the vendor
has its own SATA solution and at least in the ARM world it seems frequent
to have its own AHCI variant nowadays.  Moreover even if the new usage
shows up it is not enough to enable driver for it to make it work as
you also need to add a node describing your SATA MV variant to your SoC
device tree file (which requires updating kernel source anyway).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
