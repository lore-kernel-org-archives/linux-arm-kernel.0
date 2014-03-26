From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Mar 2014 17:57:49 +0100
Subject: [PATCH] ata: fix Marvell SATA driver dependencies
In-Reply-To: <20140326162302.GG25349@lunn.ch>
References: <5138028.BSQbEP7RRB@amdc1032> <20140326162302.GG25349@lunn.ch>
Message-ID: <2706133.4NFborHvE6@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Wednesday, March 26, 2014 05:23:02 PM Andrew Lunn wrote:
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
> this driver.

Currently no powerpc platform uses this driver for non-PCI devices and
looking at commits history for powerpc dts files it seems that it also
hasn't happened in the past.

I think that the current patch is sufficient as we can always relax
dependencies later if the need for it shows up + there is a possibility
to (ab)use COMPILE_TEST for older kernels.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
