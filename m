From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 3 Dec 2012 17:25:25 +0000
Subject: Replacing dma_alloc_writecombine for aarch64
In-Reply-To: <CAD0U-h+a6_1gtTS9pq-p7_BPmNnghUMMFZAHr8JdiK1kXrEHZQ@mail.gmail.com>
References: <CAD0U-h+a6_1gtTS9pq-p7_BPmNnghUMMFZAHr8JdiK1kXrEHZQ@mail.gmail.com>
Message-ID: <20121203172525.GD4261@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 05:18:35PM +0000, Ryan Harkin wrote:
> Some time ago, I converted the PL111 driver to use device tree [1].  I
> gathered some feedback after an RFC and I was recently updating my
> driver.  However, with my aarch64 work, I found that the driver
> doesn't compile for aarch64 because I've been using
> dma_alloc_writecombine in the driver.  As aarch64 doesn't use the
> driver with DMA, I hacked it to get my aarch64 branch working.
> 
> Is there another API you can recommend I use for DMA that will work
> with both flavours?

You can use dma_alloc_coherent() which gives the same thing on ARMv7
(and some ARMv6) and AArch64 (write-combine memory). However, there is
ARMv5 where this translates to strongly ordered memory, so you can't the
coherent variant all the time.

-- 
Catalin
