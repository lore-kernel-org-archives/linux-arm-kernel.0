From: hch@lst.de (Christoph Hellwig)
Date: Sat, 12 May 2018 14:38:29 +0200
Subject: [PATCH v3 3/3] arm64: Force swiotlb bounce buffering for
 non-coherent DMA with large CWG
In-Reply-To: <20180511135547.34521-4-catalin.marinas@arm.com>
References: <20180511135547.34521-1-catalin.marinas@arm.com>
 <20180511135547.34521-4-catalin.marinas@arm.com>
Message-ID: <20180512123829.GA8024@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 02:55:47PM +0100, Catalin Marinas wrote:
> On systems with a Cache Writeback Granule (CTR_EL0.CWG) greater than
> ARCH_DMA_MINALIGN, DMA cache maintenance on sub-CWG ranges is not safe,
> leading to data corruption. If such configuration is detected, the
> kernel will force swiotlb bounce buffering for all non-coherent devices.

Per the previous discussion I understand that so far this is a
purely theoretical condition.  Given that I'd rather avoid commiting
this patch and just refuse too boot in this case.

In a merge window or two I plan to have a noncoherent flag in struct
device, at which point we can handle this entirely in common code.
