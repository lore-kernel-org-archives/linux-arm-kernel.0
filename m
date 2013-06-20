From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 12:13:13 +0200
Subject: [Linaro-mm-sig] [RFC 2/3] ARM: dma-mapping: Pass DMA attrs as
 IOMMU prot
In-Reply-To: <20130620.125431.1161068035083905855.hdoyu@nvidia.com>
References: <CAMcxFTRnnCnPnvMi89r7rUsN4xeYzZGqy9s5v5ukm_fJ_d_RGg@mail.gmail.com>
 <CAMcxFTS0dUUEfGj-=-cb_rdfy+qWvtsaoR6Tv+-x05XX0mZmmw@mail.gmail.com>
 <20130620.125431.1161068035083905855.hdoyu@nvidia.com>
Message-ID: <201306201213.13644.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Hiroshi Doyu wrote:
> > If devices allocate via dma-mapping API, physical mem allocation, iova
> > allocation and iommu mapping happens internally.
> > Devices may allocate physical memory using any allocator (say ION
> > including carveout area), use "iommu mapping" API which will do iova
> > allocation and iommu mapping. The prot flags could be useful in this
> > case as well - not sure whether we would need dma-attrs here.
> 
> I haven't followed ION recently, but can't ION backed by DMA mapping
> API instead of using IOMMU API directly?

For a GPU with an IOMMU, you typically want per-process IOMMU contexts,
which are only available when using the IOMMU API directly, as the
dma-mapping abstraction uses only one context for kernel space.

	Arnd
