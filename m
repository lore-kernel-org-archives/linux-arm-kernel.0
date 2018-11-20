From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Nov 2018 17:07:42 +0100
Subject: [PATCH 1/2] swiotlb: Make DIRECT_MAPPING_ERROR viable
In-Reply-To: <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
 <e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
Message-ID: <20181120160742.GA2492@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subject line should say dma-direct.  This isn't really swiotlb
specific.

> +#define DIRECT_MAPPING_ERROR		~(dma_addr_t)0

Please add braces around the value like the other *MAPPING_ERROR
defintions so that it can be safely used in any context.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
