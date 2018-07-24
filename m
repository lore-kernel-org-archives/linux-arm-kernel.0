From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 24 Jul 2018 11:09:06 -0700
Subject: [PATCH] ARM: dma-mapping: always clear allocated buffers
In-Reply-To: <20180724140435.17112-1-yuehaibing@huawei.com>
References: <20180724140435.17112-1-yuehaibing@huawei.com>
Message-ID: <20180724180906.GA8240@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 10:04:35PM +0800, YueHaibing wrote:
> Sean Wang report dma_zalloc_coherent doesn't work as expect on his
> armv7,the allocated mem is not zeroed.The reason is __alloc_from_pool
> doesn't honor __GFP_ZERO.

Please explain the "why" a little more.  All the explanations are in
the referenced arm64 commit and should be mentioned here as well.
