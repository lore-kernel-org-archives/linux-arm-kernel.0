From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 16:35:17 +0100
Subject: [PATCH 08/22] swiotlb: wire up ->dma_supported in swiotlb_dma_ops
In-Reply-To: <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-9-hch@lst.de>
 <7a058876-08fc-7323-7cb3-fe85116e2ea8@arm.com>
Message-ID: <20180110153517.GF17790@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 12:16:15PM +0000, Robin Murphy wrote:
> On 10/01/18 08:09, Christoph Hellwig wrote:
>> To properly reject too small DMA masks based on the addressability of the
>> bounce buffer.
>
> I reckon this is self-evident enough that it should simply be squashed into 
> the previous patch.

x86 didn't wire it up before, so I want a clear blaimpoint for this
change instead of mixing it up.
