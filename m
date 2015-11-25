From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 21:09:15 +0100
Subject: [RFC PATCH] PCI/pci-host-generic: Add support for Cavium Thunder
 fixed BARs.
In-Reply-To: <5656149D.50704@caviumnetworks.com>
References: <1443488184-12633-1-git-send-email-ddaney.cavm@gmail.com>
 <2789794.TBZL2yW2b6@wuerfel> <5656149D.50704@caviumnetworks.com>
Message-ID: <2971730.8fz1SdakMA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 12:05:49 David Daney wrote:
> 
> Somebody should make a decision about this point.
> 
> Here is what happens:
> 
>   1) A driver for non-generic PCI host bridge is submitted.
> 
>   2) Comments are received stating that it is just another PCI host 
> bridge and please use pci-host-generic instead.
> 
>   3) Patches to pci-host-generic are submitted.
> 
>   4) Comments are received stating that pci-host-generic is for generic 
> things only, and please create a device specific driver.
> 
>   5) goto 1

I'm pretty sure the comments were along the lines of 

1) a driver was submitted stating that it was for an SBSA-compliant
   platform

2) The reply was that you don't need a driver for that and just use
   the generic driver, as that is the point of SBSA

3) it turns out the hardware is nonstandard after all and so it needs
   its own driver.

> > It's easy enough to split out the common parts if we want to reuse
> > some of this, or to move them into drivers/pci/*.c for others to
> > reuse too.
> >
> 
> If we do that, do you want "pci-host-cam-generic" and 
> "pci-host-ecam-generic" split out too?
> 
> They are two completely different things crammed into the single 
> pci-host-generic driver source file.  Or is there some set of config 
> access methods that are sufficiently generic that they can stay?

Those two are part of the PCI standard, they are obviously generic
because any mmconfig compliant host bridge will work with one or the
other.

	Arnd
