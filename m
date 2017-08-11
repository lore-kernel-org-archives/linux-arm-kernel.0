From: hch@lst.de (Christoph Hellwig)
Date: Fri, 11 Aug 2017 19:56:41 +0200
Subject: [PATCH 1/2] of: Fix DMA mask generation
In-Reply-To: <0819179085df6c41c70e83a2c5c138b95c0386b3.1502468875.git.robin.murphy@arm.com>
References: <0819179085df6c41c70e83a2c5c138b95c0386b3.1502468875.git.robin.murphy@arm.com>
Message-ID: <20170811175641.GA1921@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 11, 2017 at 05:29:56PM +0100, Robin Murphy wrote:
> Historically, DMA masks have suffered some ambiguity between whether
> they represent the range of physical memory a device can access, or the
> address bits a device is capable of driving, particularly since on many
> platforms the two are equivalent. Whilst there are some stragglers left
> (dma_max_pfn(), I'm looking at you...), the majority of DMA code has
> been cleaned up to follow the latter definition, not least since it is
> the only one which makes sense once IOMMUs are involved.

I think it always was supposed to be the latter, but that doesn't mean
that everyone got the message :)

> Either of these patches alone should be sufficient to un-break RPi3,
> and they apply independently, so I'm quite happy for one to go in as a
> fix now and the other to wait for 4.14.

This one is something I'm comfortable feeding to Linus for 4.13
if I get a few ACKs from people familar with the OF code and intended
meaning of the ranges in the device tree.
