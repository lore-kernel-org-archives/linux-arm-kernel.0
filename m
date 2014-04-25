From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Apr 2014 22:05:50 +0200
Subject: [PATCH] pci-rcar-gen2: add device tree support
In-Reply-To: <20140425174535.GF32246@google.com>
References: <201404080141.21605.sergei.shtylyov@cogentembedded.com>
 <20140425174535.GF32246@google.com>
Message-ID: <23319337.TNDCodMgFf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 April 2014 11:45:35 Bjorn Helgaas wrote:
> > +This is the bridge used internally to connect the USB controllers to the
> > +AHB. There is one bridge instance per USB port connected to the internal
> > +OHCI and EHCI controllers.
> > +
> > +Required properties:
> > +- compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
> > +           "renesas,pci-r8a7791" for the R8A7791 SoC.
> > +- reg:       A list of physical regions to access the device: the first is
> > +     the operational registers for the OHCI/EHCI controllers and the
> > +     second is for the bridge configuration and control registers.
> > +- interrupts: interrupt for the device.
> > +- clocks: The reference to the device clock.
> > +- bus-range: The PCI bus number range; as this is a single bus, the range
> > +           should be specified as the same value twice.

Actually, this doesn't conform to the generic PCI binding, which requires
a number of additional properties.

	Arnd
