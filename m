From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jun 2013 10:43:01 +0200
Subject: [PATCH] arch: arm64: include: asm: add pci.h to pass compiling
In-Reply-To: <51CB87B0.8030805@asianux.com>
References: <51CA5F71.207@asianux.com> <20130626140730.GB23309@arm.com>
 <51CB87B0.8030805@asianux.com>
Message-ID: <9028702.KGsxCx1772@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 June 2013 08:30:40 Chen Gang wrote:
> On 06/26/2013 10:07 PM, Catalin Marinas wrote:
> > On Wed, Jun 26, 2013 at 04:26:41AM +0100, Chen Gang wrote:
> > I wonder whether it makes sense to include pci-dma-compat.h in
> > asm-generic/pci.h, I don't see why one would want the generic pci.h but
> > not the generic pci-dma-compat.h (cc'ing Arnd).
> 
> I think, it will let architecture guys easier to add their own
> pci-dma-compat.h (although they still need generic pci_dma_compat.h, and
> generic pci.h, too).
> 
> e.g. one architecture want include generic pci-dma-compat.h firstly,
> then define its own features in its own pci-dma-compat.h.

I think there is no excuse for still keeping the asm-generic/pci-dma-compat.h
header around any more.

All architectures use the same implementation and have done so for years.
We should just convert the remaining users to use the dma_mapping.h
interfaces directly.

	Arnd
