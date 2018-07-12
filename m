From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Thu, 12 Jul 2018 11:24:46 +0200
Subject: [PATCH 0/3] PCI: emulated PCI bridge common logic
In-Reply-To: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
References: <20180629092231.32207-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180712112446.74998bd9@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn, Lorenzo,

On Fri, 29 Jun 2018 11:22:28 +0200, Thomas Petazzoni wrote:

> The pci-mvebu driver already contains some logic to emulate a root
> port PCI bridge. It turns out that we have a similar need for the
> pci-aardvark driver. Instead of duplicating the same logic in two
> drivers, this patch series starts by adding a small common
> infrastructure that helps emulate a root port PCI bridge, converts
> pci-mvebu to use it, and finally extends pci-aardvark to use it as
> well.
> 
> Thanks to this, Marvell Armada 3720 based systems, which use the
> Aarkvark PCI controller, will have better PCI support, by having a
> root port PCI bridge exposed.
> 
> The emulated PCI bridge common logic is a proposal, I very much
> welcome comments and suggestions. Also, if you feel that adding a
> common logic for only two drivers is too early, I'm fine with
> duplicating a bit of code betwen pci-mvebu and pci-aardvark.

I was wondering if you had any feedback on this patch series. Not
necessarily a detailed review, but at least some general
feeling/feedback on the overall approach would be very nice.

Thanks a lot,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
