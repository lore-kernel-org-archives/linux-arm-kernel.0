From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Feb 2014 11:26:15 +0100
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
In-Reply-To: <CAAhSdy0X56UcMrp0bsH0na=GBkND=jqZVqbHxKsBampr8YM3cA@mail.gmail.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <1391532784-1953-3-git-send-email-will.deacon@arm.com>
 <CAAhSdy0X56UcMrp0bsH0na=GBkND=jqZVqbHxKsBampr8YM3cA@mail.gmail.com>
Message-ID: <2629498.fOknbqpyEP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 February 2014 14:24:03 Anup Patel wrote:
> > diff --git a/Documentation/devicetree/bindings/pci/linux,pci-virt.txt b/Documentation/devicetree/bindings/pci/linux,pci-virt.txt
> > new file mode 100644
> > index 000000000000..54668a283498
> > +- compatible     : Must be "linux,pci-virt"
> > +
> > +- ranges         : As described in IEEE Std 1275-1994, but must provide
> > +                   at least a definition of the Configuration Space plus
> > +                   one or both of IO and Memory Space.
> > +
> > +- #address-cells : Must be 3
> > +
> > +- #size-cells    : Must be 2
> > +
> > +Configuration Space is assumed to be memory-mapped (as opposed to being
> 
> It would be great to have a flag to specify whether Configuration Space is over
> ioports or memory mapped.
> 

I haven't seen config space access through ioport for a long
time on non-x86. Do you have reason to believe that we will need
that?

	Arnd
