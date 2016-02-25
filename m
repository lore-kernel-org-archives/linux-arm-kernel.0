From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Feb 2016 15:00:54 +0000
Subject: RFC: extend IOMMU attributes
In-Reply-To: <20160225143855.GD16675@8bytes.org>
References: <HE1PR04MB1641F22E38710B68F4ED891F8DAF0@HE1PR04MB1641.eurprd04.prod.outlook.com>
 <20160225143855.GD16675@8bytes.org>
Message-ID: <20160225150053.GA15330@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 03:38:55PM +0100, joro at 8bytes.org wrote:
> On Thu, Feb 18, 2016 at 04:16:26PM +0000, Stuart Yoder wrote:
> >  #define IOMMU_READ            (1 << 0)
> >  #define IOMMU_WRITE           (1 << 1)
> > -#define IOMMU_CACHE           (1 << 2) /* DMA cache coherency */
> > +#define IOMMU_CACHE_COHERENT  (1 << 2) /* cacheable and coherent */
> >  #define IOMMU_NOEXEC          (1 << 3)
> >  #define IOMMU_MMIO            (1 << 4) /* e.g. things like MSI doorbells */
> > +#define IOMMU_CACHEABLE       (1 << 5) /* cacheable, not coherent */
> > +#define IOMMU_CACHE_ALLOCATE  (1 << 6) /* hint to allocate in the cache */
> 
> Hmm, this might be a valid use-case to introduce the
> map_attr()/unmap_attr() calls to the IOMMU-API. I have been resistant to
> these functions until now because the proposed use-cases were not
> convincing, but for hardware-specific map-attributes like this one it
> could make sense.

So this particular use-case is completely insane, but something like
read/write allocation hints could make sense for arm-smmu systems.

Will
