From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Jun 2013 11:38:05 +0100
Subject: DMA mapping API(IOMMU) for ARM64?
In-Reply-To: <5159282.rrJMaZuYMv@wuerfel>
References: <20130618.053955.305832937374936961.hdoyu@nvidia.com>
 <20130618101914.GB3539@mudshark.cambridge.arm.com>
 <5159282.rrJMaZuYMv@wuerfel>
Message-ID: <20130618103804.GI9930@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:32:44AM +0100, Arnd Bergmann wrote:
> On Tuesday 18 June 2013 11:19:14 Will Deacon wrote:
> > I've spoken briefly with Catalin about this and it seems like there might be
> > *some* scope for sharing common dma-mapping code between architectures.
> > There doesn't really need to be any architecture-specific details in
> > allocating iova space and the interface to the iommu drivers is
> > well-defined. The arch-specific stuff is bogged down in the non-coherent
> > buffer management, but that doesn't necessarily equate to lots of code.
> > 
> > So, the best bet would be to figure out how to split up what we have under
> > arch/arm/ so that it can be re-used by arm64 and potentially other
> > architectures (powerpc has some simple stuff for coherent mappings and some
> > less-simple stuff for non-coherent buffers).
> 
> I'm sure that other architectures are interested in sharing the code.
> Best move it into the global mm/ directory, at least the version for
> coherent mappings.

Or we could extend the lib/iommu-helper.c or add another file in there
(we already have lib/swiotlb.c).

-- 
Catalin
