From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 27 Apr 2017 11:40:20 +0100
Subject: [RFC/RFT PATCH 07/18] ARM: PCI: orion5x: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426185348.GB14074@lunn.ch>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-8-lorenzo.pieralisi@arm.com>
 <20170426151257.GA4489@lunn.ch> <20170426161335.GA12240@red-moon>
 <20170426185348.GB14074@lunn.ch>
Message-ID: <20170427104020.GA15685@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 08:53:48PM +0200, Andrew Lunn wrote:
> > > Note that IRQ 12 has disappeared from Flags: on 0000:00:00.0.
> > 
> > Thank you for testing it, that's exactly what we need.
> > 
> > To check if the plumbing is working (ie to check I have not messed
> > up the bus scan API rework), mind testing the patch below please
> > and report back (it applies on top of this series) ?
> 
> 0000:00:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Subsystem: Marvell Technology Group Ltd. Device 11ab
>         Flags: bus master, fast devsel, latency 0, IRQ 12
> 
> The interrupt is back with this patch.

Ok the IRQ allocation works then, the difference is when the mapping
is called, original patch series moves the IRQ allocation to device
probe time (that's why IRQ does not show up, there is no matching
driver in the kernel for the PCI device above), with the additional
patch the IRQ allocation is done when the PCI device is added.

It is a user visible change, not sure though if that's a real issue,
that's exactly the reason why I posted this series, to find out
and converge.

Thanks !
Lorenzo
