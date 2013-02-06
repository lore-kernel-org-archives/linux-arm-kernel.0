From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 7 Feb 2013 00:07:15 +0100
Subject: [PATCH v2 22/27] arm: mvebu: add PCIe Device Tree informations
 for Armada XP
In-Reply-To: <201302062241.14444.arnd@arndb.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-23-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302062241.14444.arnd@arndb.de>
Message-ID: <20130207000715.0b3d662d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 6 Feb 2013 22:41:14 +0000, Arnd Bergmann wrote:

> I've been thinking some more about this, and I wonder if it would
> make more sense to describe the address remapping correctly as
> a node on top of the pcie-controller node.
> 
> This would mean that rather than putting the mapped physical address
> (0xc0000000, 0xc1000000, ...) in here, you would actually have 64-bit
> address as the destination as well, in whatever format the
> address map hardware uses, I assume using a numbered 32 bit
> address space for each object that can be remapped.
> 
> This would also let you do the PCI memory address assignment for
> each port separately, starting at bus address 0, followed by
> finding a location in the CPU address space and passing
> the start as the sys->mem_offset argument to
> pci_add_resource_offset.

Hum, good you give a skeleton example, because I'm not sure to
understand your suggestion.


> 
> > +                       pcie at 0,0 {
> > +                               device_type = "pciex";
> > +                               reg = <0x0800 0 0xd0040000 0
> > 0x2000>;
> > +                               #address-cells = <3>;
> > +                               #size-cells = <2>;
> > +                               marvell,pcie-port = <0>;
> > +                               marvell,pcie-lane = <0>;
> > +                               interrupts = <1>;
> > +                               clocks = <&gateclk 5>;
> > +                               status = "disabled";
> > +                       };
> 
> I think you are missing a "ranges" property here, at least an empty
> one, which is required by the standard but not currently enforced
> in the code.

Is it really wise to have DT properties that are not used by anything,
and therefore have a very high chance of either being incorrect, or
becoming incorrect?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
