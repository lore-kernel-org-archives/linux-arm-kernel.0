From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Feb 2014 20:57:26 +0100
Subject: DMABOUNCE in pci-rcar
In-Reply-To: <CAErSpo5RV=w+DkgHSZZPOFGiEBBxMSraLV3TepYUZwDJuV+Jzg@mail.gmail.com>
References: <201402241200.21944.arnd@arndb.de>
 <CAErSpo5RV=w+DkgHSZZPOFGiEBBxMSraLV3TepYUZwDJuV+Jzg@mail.gmail.com>
Message-ID: <5165962.7bqj51B15Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 February 2014 12:48:17 Bjorn Helgaas wrote:
> On Mon, Feb 24, 2014 at 4:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Hi Magnus,
> >
> > I noticed during randconfig testing that you enabled DMABOUNCE for the
> > pci-rcar-gen2 driver as posted in this patch https://lkml.org/lkml/2014/2/5/30
> >
> > I didn't see the original post unfortunately, but I fear we have to
> > revert it and come up with a better solution, ...
> 
> Sounds like I should drop the following patches from my pci/host-rcar
> branch for now?
> 
>   PCI: rcar: Add DMABOUNCE support
>   PCI: rcar: Enable BOUNCE in case of HIGHMEM
>   PCI: rcar: Make the Kconfig dependencies more generic

Sounds good to me. The last patch is actually fine, but you'll have to
fix the context to apply it without the other two.

	Arnd
