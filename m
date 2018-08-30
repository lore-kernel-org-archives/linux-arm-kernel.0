From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Aug 2018 10:59:37 -0700
Subject: [RFC 3/3] stk1160: Use non-coherent buffers for USB transfers
In-Reply-To: <20180830172030.23344-4-ezequiel@collabora.com>
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-4-ezequiel@collabora.com>
Message-ID: <20180830175937.GB11521@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	dma_sync_single_for_cpu(&urb->dev->dev, urb->transfer_dma,
> +		urb->transfer_buffer_length, DMA_FROM_DEVICE);

You can't ue dma_sync_single_for_cpu on non-coherent dma buffers,
which is one of the major issues with them.
