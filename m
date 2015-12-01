From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 1 Dec 2015 10:03:54 +0000
Subject: when will irq parameter in struct pci_dev be used
In-Reply-To: <2760658.czteIK1m3n@wuerfel>
References: <loom.20151201T062147-753@post.gmane.org>
 <2760658.czteIK1m3n@wuerfel>
Message-ID: <8520D5D51A55D047800579B094147198258679C2@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: when will irq parameter in struct pci_dev be used
> 
> On Tuesday 01 December 2015 05:30:45 bharat kumar gogada wrote:
> > Hi, In arm64 when will the 'irq' parameter in struct pci_dev will be
> > used in kernel, how it will be used in legacy interrupts and how it
> > will be used in MSI interrupts, when we have MSI domains.
> 
> The number is initialized with whatever legacy interrupt you list in the
> interrupt-map property of the PCI host device node for this device, and
> drivers are supposed to use it from there.
> 
> For MSI, see Documentation/PCI/MSI-HOWTO.txt
> 
Yes I have seen that in arm/arch64/kernel/pci.c, in function pcibios_add_device this number is getting updated w.r.t to interrupt map property. So the host bridge gets this number, so you meant like, first end point device will get this irq number when it asks through request irq, if it is legacy interrupt, and if another legacy request comes this will be incremental. If it is MSI it depends on MSI domain present in root port driver, End point will get different number irrespective of this irq number.
