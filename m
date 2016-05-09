From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 9 May 2016 13:21:38 +0200
Subject: [PATCH 0/5] Introduce per-domain page sizes
In-Reply-To: <cover.1460048991.git.robin.murphy@arm.com>
References: <cover.1460048991.git.robin.murphy@arm.com>
Message-ID: <20160509112138.GB13275@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 07, 2016 at 06:42:03PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Since this area seems to be in vogue at the moment, here's what I was
> working on when the related patches[1][2] popped up, which happens to
> be more or less the intersection of both. As I recycled some of Will's
> old series as a starting point, I've retained the cleanup patches from
> that with their original acks - hope that's OK.
> 
> Fortunately, this already looks rather like parts of Joerg's plan[3],
> so I hope it's a suitable first step. Below is a quick hacked-up example
> of the kind of caller-controlled special use-case alluded to, using the
> SMMU/HDLCD combo on Juno - for a 'real' implementation of this we'd want
> the group-based domain allocation call so the driver could throw the
> device at that and get its own non-default DMA ops domain to play with.
> 
> Robin.
> 
> [1]:http://thread.gmane.org/gmane.linux.kernel.iommu/12774
> [2]:http://thread.gmane.org/gmane.linux.kernel.iommu/12901
> [3]:http://article.gmane.org/gmane.linux.kernel.iommu/12937
> 
> Robin Murphy (4):
>   iommu: of: enforce const-ness of struct iommu_ops
>   iommu: Allow selecting page sizes per domain
>   iommu/dma: Finish optimising higher-order allocations
>   iommu/arm-smmu: Use per-domain page sizes.
> 
> Will Deacon (1):
>   iommu: remove unused priv field from struct iommu_ops

Okay, I am still no happy that this lifts the requirements of the
iommu-api for the arm-smmu driver. But to get there we need more core
changes and this code is a step in the right direction, so I applied it.

Thanks,

	Joerg
