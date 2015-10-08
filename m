From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 17:11:32 +0200
Subject: [PATCH v4 4/5] PCI: generic: Correct, and avoid overflow,
 in bus_max calculation.
In-Reply-To: <20151008150243.GC3885@localhost>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
 <1443811443-18878-5-git-send-email-ddaney.cavm@gmail.com>
 <20151008150243.GC3885@localhost>
Message-ID: <5230007.h2fkbnOlh5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 October 2015 10:02:43 Bjorn Helgaas wrote:
> [+cc Arnd]
> 
> And this one?

Not so good.

> > --- a/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.txt
> > @@ -34,7 +34,11 @@ Properties of the host controller node:
> >  - #size-cells    : Must be 2.
> >  
> >  - reg            : The Configuration Space base address and size, as accessed
> > -                   from the parent bus.
> > +                   from the parent bus.  The base address corresponds to
> > +                   bus zero, even though the "bus-range" property may specify
> > +                   a different starting bus number.  The driver must only map
> > +                   or access the portion of the Configuration Space that
> > +                   corresponds to the "bus-range"

I thought we had reached an agreement that it is a bad idea to have a 'reg'
property that lists registers belonging to a different device.

	Arnd
