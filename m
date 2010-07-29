From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 09:50:56 +0100
Subject: [PATCH 1/2] [ARM] dmabounce: add support for low bitmasks in
	dmabounce
In-Reply-To: <1280365067-21102-2-git-send-email-gking@nvidia.com>
References: <1280365067-21102-1-git-send-email-gking@nvidia.com>
	<1280365067-21102-2-git-send-email-gking@nvidia.com>
Message-ID: <20100729085056.GA14880@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 05:57:46PM -0700, gking at nvidia.com wrote:
> some systems have devices which require DMA bounce buffers due to
> alignment restrictions rather than address window restrictions.
> 
> detect when a device's DMA mask has low bits set to zero and treat
> this as an alignment for DMA pool allocations, but ignore the low
> bits for DMA valid window comparisons.

Why can't you arrange for the originally allocated buffer to have the
necessary alignment?  What kind of devices have this problem?  Are
there cases where the alignment is greater than the L1 cache line size?
