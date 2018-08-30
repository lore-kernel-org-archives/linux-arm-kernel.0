From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 30 Aug 2018 10:58:50 -0700
Subject: [RFC 2/3] USB: core: Add non-coherent buffer allocation helpers
In-Reply-To: <20180830172030.23344-3-ezequiel@collabora.com>
References: <20180830172030.23344-1-ezequiel@collabora.com>
 <20180830172030.23344-3-ezequiel@collabora.com>
Message-ID: <20180830175850.GA11521@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please don't introduce new DMA_ATTR_NON_CONSISTENT users, it is
a rather horrible interface, and I plan to kill it off rather sooner
than later.  I plan to post some patches for a better interface
that can reuse the normal dma_sync_single_* interfaces for ownership
transfers.  I can happily include usb in that initial patch set based
on your work here if that helps.
