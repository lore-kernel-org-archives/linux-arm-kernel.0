From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Jun 2016 14:19:07 +0200
Subject: [PATCH 2/3] PCI: host: new PCI host controller driver for Marvell
 Armada 3700
In-Reply-To: <20160609111921.11975627@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <3112077.0RPfokLCAs@wuerfel> <20160609111921.11975627@free-electrons.com>
Message-ID: <11140978.npsCNQs782@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 9, 2016 11:19:21 AM CEST Thomas Petazzoni wrote:
> > What is the version of the GIC in the Armada 3700? If you have GICv3
> > or GICv2m, could you use that instead of the built-in MSI logic?
> > 
> > We typically handle this using the msi-map or msi-parent properties
> > pointing to either the gic or the PCI host, depending on which one
> > you want to use, but either of them should work, and the GIC should
> > be more efficient because you can distribute the interrupts of the
> > PCI devices over all CPUs by workload, rather than having to
> > multiplex all MSI through a single GIC interrupt.
> 
> There is a GIC-500, but Marcin told me that attempts to use MSI with it
> have not been successful so far. There will be investigation on this
> topic in the future, but for the moment, we'd like to have the MSI
> functionality built into the PCIe driver supported. We can migrate
> later to GIC-500 powered MSIs once working.

I think you should still add the msi-parent or msi-map properties then,
just have them point at the PCI host node instead of the GIC-500,
and evaluate that to get the built-in controller.

	Arnd
