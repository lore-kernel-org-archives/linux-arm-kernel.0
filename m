From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jun 2012 10:25:09 +0000
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <20120614083719.GC31283@avionic-0098.mockup.avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <201206132021.09774.arnd@arndb.de>
 <20120614083719.GC31283@avionic-0098.mockup.avionic-design.de>
Message-ID: <201206141025.09325.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 June 2012, Thierry Reding wrote:
> > 
> > I believe you will need an "interrupt-map" property here, to map the host
> > interrupts to the INTA-INTD lines of the attached devices.
>
> Legacy interrupts are something I cannot test at all because I have no
> hardware that supports them.

Hmm, I thought all PCIe hardware has to support them when you do not
enable MSI. What hardware do you have then?

> > I'm not sure whether we want to have a device_type="pciex" property here.
> > powerpc and sparc seem to use that information, to distinguish a pcie
> > bus from pci or cardbus.
> 
> That'd be rather useless information given that the Tegra is unlikely to
> support either PCI or CardBus at some point.

But the generic code does not know that.

	Arnd
