From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Oct 2010 12:32:09 +0100
Subject: [RFC PATCH 13/18] ARM: LPAE: ensure dma_addr_t is the same
	size as phys_addr_t
In-Reply-To: <201010251308.24063.arnd@arndb.de>
References: <20101025085812.25275.55757.stgit@e102109-lin.cambridge.arm.com>
	<20101025090046.25275.80297.stgit@e102109-lin.cambridge.arm.com>
	<201010251308.24063.arnd@arndb.de>
Message-ID: <1288006329.14756.13.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-25 at 12:08 +0100, Arnd Bergmann wrote:
> On Monday 25 October 2010, Catalin Marinas wrote:
> > From: Will Deacon <will.deacon@arm.com>
> >
> > Now that phys_addr_t can be 64-bit on ARM, we must ensure that dma_addr_t
> > is sufficiently large to hold physical addresses.
> >
> > This patch uses the types.h implementation in asm-generic to define the
> > dma_addr_t type as the same width as phys_addr_t.
> >
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> This patch will become obsolete once the "unify dma_addr_t typedef"
> series from Fujita Tomonori is upstream, you will instead have to set
> CONFIG_ARCH_DMA_ADDR_T_64BIT.

Yes, I know this and it's on my list to fix once I update the patches to
2.6.37-rc1.

Thanks,

Catalin
