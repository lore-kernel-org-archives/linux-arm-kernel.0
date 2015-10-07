From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 7 Oct 2015 15:13:38 +0000
Subject: Irq domain for legacy interrupts
In-Reply-To: <41520723.9CcSmQjLSU@wuerfel>
References: <loom.20151007T164737-541@post.gmane.org>
 <41520723.9CcSmQjLSU@wuerfel>
Message-ID: <8520D5D51A55D047800579B094147198016907D5@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In arch/arm64/kernel/pci.c, pcibios_add_device(struct pci_dev *dev) does the irq mapping so, at this point of time the registered irq domain mapping will be invoked at this time ?

-----Original Message-----
From: Arnd Bergmann [mailto:arnd at arndb.de] 
Sent: Wednesday, October 07, 2015 8:33 PM
To: linux-arm-kernel at lists.infradead.org
Cc: Bharat Kumar Gogada
Subject: Re: Irq domain for legacy interrupts

On Wednesday 07 October 2015 14:53:03 bharat kumar gogada wrote:
> why do we need a irq domain for legacy interrupts ?

You need an irq domain if you want to refer to the interrupts from DT, otherwise you have no way to describe them.

> Do we need any specific
> parameter in device tree other that interrupt-map, interrupt-map-mask, 
> for handling with irq domain ?

no.

> when will the .map method in struct irq_domain_ops get invoked for 
> legacy interrupts ?

when the interrupt gets mapped ;-)

This should happen whenever the first PCIe device starts using non-MSI interrupts.

	Arnd
