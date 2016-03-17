From: martin@sperl.org (Martin Sperl)
Date: Thu, 17 Mar 2016 11:22:23 +0100
Subject: [PATCH 0/8 v4] bcm2835 DMA slave support
In-Reply-To: <1458156302-4359-1-git-send-email-eric@anholt.net>
References: <1458156302-4359-1-git-send-email-eric@anholt.net>
Message-ID: <56EA855F.1010607@sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.03.2016 20:24, Eric Anholt wrote:
> Here's the series for DMA slave and memcpy support for 2835, with the
> DT changes to enable the remaining channels dropped out while that
> goes through review.  I had to do some minor conflict resolution, but
> it was pretty mechanical, and I tested again with dmatest on the last
> patch.
I guess I have got a list to implement that without a change to the 
device tree,
besides making use of platform_get_irq_byname and setting up the property:
     interrupt-names = "dma0", "dma1", .. "dma10", "dma_shared", "dma_all";

As the property "interrupt-names" is a standard it should be acceptable.
