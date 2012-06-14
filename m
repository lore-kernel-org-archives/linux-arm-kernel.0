From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 14 Jun 2012 10:37:19 +0200
Subject: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
In-Reply-To: <201206132021.09774.arnd@arndb.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <4FD84133.4060401@firmworks.com>
 <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de>
 <201206132021.09774.arnd@arndb.de>
Message-ID: <20120614083719.GC31283@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 08:21:08PM +0000, Arnd Bergmann wrote:
> On Wednesday 13 June 2012, Thierry Reding wrote:
> >                 pci at 80000000 {
> >                         reg = <0x80000000 0x00001000>;
> >                         status = "disabled";
> > 
> >                         #address-cells = <3>;
> >                         #size-cells = <2>;
> > 
> >                         ranges = <0x80400000 0x80400000 0x00008000   /* I/O */
> >                                   0x90000000 0x90000000 0x08000000   /* non-prefetchable memory */
> >                                   0xa0000000 0xa0000000 0x08000000>; /* prefetchable memory */
> > 
> >                         nvidia,ctrl-offset = <0x0>;
> >                         nvidia,num-lanes = <2>;
> >                 };
> > 
> 
> I believe you will need an "interrupt-map" property here, to map the host
> interrupts to the INTA-INTD lines of the attached devices.

Legacy interrupts are something I cannot test at all because I have no
hardware that supports them.

> I'm not sure whether we want to have a device_type="pciex" property here.
> powerpc and sparc seem to use that information, to distinguish a pcie
> bus from pci or cardbus.

That'd be rather useless information given that the Tegra is unlikely to
support either PCI or CardBus at some point.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/b90536c5/attachment-0001.sig>
