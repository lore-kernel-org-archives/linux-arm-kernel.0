From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 10:48:32 +0100
Subject: when will irq parameter in struct pci_dev be used
In-Reply-To: <loom.20151201T062147-753@post.gmane.org>
References: <loom.20151201T062147-753@post.gmane.org>
Message-ID: <2760658.czteIK1m3n@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 05:30:45 bharat kumar gogada wrote:
> Hi, In arm64 when will the 'irq' parameter in struct pci_dev will be used in
> kernel, how it will be used in legacy interrupts and how it will be used in
> MSI interrupts, when we have MSI domains.

The number is initialized with whatever legacy interrupt you list in
the interrupt-map property of the PCI host device node for this device,
and drivers are supposed to use it from there.

For MSI, see Documentation/PCI/MSI-HOWTO.txt

	Arnd
