From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jun 2011 19:00:52 +0100
Subject: [PATCH v3 1/2] omap3: iovmm: Work around sg_alloc_table size
	limitation in IOMMU
In-Reply-To: <201106061854.10450.laurent.pinchart@ideasonboard.com>
References: <20110601131744.GH11352@atomide.com>
	<201106061823.18767.laurent.pinchart@ideasonboard.com>
	<20110606164400.GA9456@n2100.arm.linux.org.uk>
	<201106061854.10450.laurent.pinchart@ideasonboard.com>
Message-ID: <20110606180052.GB9456@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 06:54:10PM +0200, Laurent Pinchart wrote:
> Of course not, but if the scatterlist is only touched by kernel code, it 
> doesn't need to be contiguous in memory. It could be allocated with vmalloc().

Except vmalloc has a higher latency and a more restrictive API than
other allocators (think about the coherency issues with SMP systems
which may have to do TLB flushing on several cores, etc.)
