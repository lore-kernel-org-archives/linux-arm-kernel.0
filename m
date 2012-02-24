From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 24 Feb 2012 14:24:04 +0100
Subject: [PATCHv6 3/7] ARM: dma-mapping: implement dma sg methods on top of
 any generic dma ops
In-Reply-To: <20120214150255.GC18359@phenom.dumpdata.com>
References: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com>
 <1328900324-20946-4-git-send-email-m.szyprowski@samsung.com>
 <20120214150255.GC18359@phenom.dumpdata.com>
Message-ID: <013401ccf2f7$9413a0e0$bc3ae2a0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, February 14, 2012 4:03 PM Konrad Rzeszutek Wilk wrote:
 
> On Fri, Feb 10, 2012 at 07:58:40PM +0100, Marek Szyprowski wrote:
> > This patch converts all dma_sg methods to be generic (independent of the
> > current DMA mapping implementation for ARM architecture). All dma sg
> > operations are now implemented on top of respective
> > dma_map_page/dma_sync_single_for* operations from dma_map_ops structure.
> 
> Looks good, except the worry I've that the DMA debug API calls are now
> lost.

Could You point me which DMA debug API calls are lost? The inline functions
from include/asm-generic/dma-mapping-common.h already have all required
dma debug calls, which replaced the previous calls in 
arch/arm/include/dma-mapping.h.

(snipped)

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
