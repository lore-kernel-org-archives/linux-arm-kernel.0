From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 29 May 2012 16:50:45 +0200
Subject: [GIT PULL] CMA and ARM DMA-mapping updates for v3.5
In-Reply-To: <20120529122932.GA24623@n2100.arm.linux.org.uk>
References: <1337672417-10065-1-git-send-email-m.szyprowski@samsung.com>
 <20120529122932.GA24623@n2100.arm.linux.org.uk>
Message-ID: <015e01cd3daa$6d910e50$48b32af0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, May 29, 2012 2:30 PM Russell King - ARM Linux wrote:

> I notice we have new warnings as a result of CMA being merged, though
> thankfully they're just in Kconfig:
> 
> warning: (ARM) selects CMA which has unmet direct dependencies (HAVE_DMA_CONTIGUOUS &&
> HAVE_MEMBLOCK && EXPERIMENTAL)
> 
> This seems totally weird: you're mandating that ARM must have CMA
> selected, but it's an experimental feature?  So you're implying that
> the entire ARM kernel becomes totally experimental for the next
> release cycle?
> 
> I think this needs fixing.

No, that wasn't my intention. I will provide a patch which removes unconditional dependency
on CMA - it will let one to disable CMA and use old allocation method if needed, but this 
requires a few more changes in the dma-mapping implementation. I wasn't aware of the 
consequences and no one has complained about this since v15 of CMA patches (Aug 2011).

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
