From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 16:30:17 +0100
Subject: [PATCH 27/33] dma-direct: use node local allocations for
 coherent memory
In-Reply-To: <3672aa56-b85c-5d2c-0c0e-709031b0c0a0@arm.com>
References: <20180110080027.13879-1-hch@lst.de>
 <20180110080027.13879-28-hch@lst.de>
 <3672aa56-b85c-5d2c-0c0e-709031b0c0a0@arm.com>
Message-ID: <20180110153017.GD17790@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 12:06:22PM +0000, Robin Murphy wrote:
> On 10/01/18 08:00, Christoph Hellwig wrote:
>> To preserve the x86 behavior.
>
> And combined with patch 10/22 of the SWIOTLB refactoring, this means 
> SWIOTLB allocations will also end up NUMA-aware, right? Great, that's what 
> we want on arm64 too :)

Well, only for swiotlb allocations that can be satisfied by
dma_direct_alloc.  If we actually have to fall back to the swiotlb
buffers there is not node affinity yet.
