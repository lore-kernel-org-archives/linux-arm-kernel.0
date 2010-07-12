From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Mon, 12 Jul 2010 10:25:08 +0900
Subject: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
In-Reply-To: <4C366678.60605@codeaurora.org>
References: <4C35034B.6040906@codeaurora.org>
	<20100707230710.GA31792@n2100.arm.linux.org.uk>
	<4C366678.60605@codeaurora.org>
Message-ID: <20100712102435B.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 08 Jul 2010 16:59:52 -0700
Zach Pfeffer <zpfeffer@codeaurora.org> wrote:

> The problem I'm trying to solve boils down to this: map a set of
> contiguous physical buffers to an aligned IOMMU address. I need to
> allocate the set of physical buffers in a particular way: use 1 MB
> contiguous physical memory, then 64 KB, then 4 KB, etc. and I need to
> align the IOMMU address in a particular way.

Sounds like the DMA API already supports what you want.

You can set segment_boundary_mask in struct device_dma_parameters if
you want to align the IOMMU address. See IOMMU implementations that
support dma_get_seg_boundary() properly.
