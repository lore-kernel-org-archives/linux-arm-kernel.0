From: mpe@ellerman.id.au (Michael Ellerman)
Date: Tue, 02 Jan 2018 20:45:30 +1100
Subject: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
In-Reply-To: <20171229081911.2802-17-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-17-hch@lst.de>
Message-ID: <878tdgtwzp.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoph Hellwig <hch@lst.de> writes:

> We want to use the dma_direct_ namespace for a generic implementation,
> so rename powerpc to the second best choice: dma_nommu_.

I'm not a fan of "nommu". Some of the users of direct ops *are* using an
IOMMU, they're just setting up a 1:1 mapping once at init time, rather
than mapping dynamically.

Though I don't have a good idea for a better name, maybe "1to1",
"linear", "premapped" ?

cheers
