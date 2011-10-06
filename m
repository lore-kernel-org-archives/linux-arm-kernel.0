From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 06 Oct 2011 16:18:36 +0200
Subject: [PATCH 7/7] ARM: integrate CMA with DMA-mapping subsystem
In-Reply-To: <1317909290-29832-8-git-send-email-m.szyprowski@samsung.com>
References: <1317909290-29832-1-git-send-email-m.szyprowski@samsung.com>
	<1317909290-29832-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <000201cc8432$d642b930$82c82b90$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, October 06, 2011 3:55 PM Marek Szyprowski wrote:

> This patch adds support for CMA to dma-mapping subsystem for ARM
> architecture. By default a global CMA area is used, but specific devices
> are allowed to have their private memory areas if required (they can be
> created with dma_declare_contiguous() function during board
> initialization).
> 
> Contiguous memory areas reserved for DMA are remapped with 2-level page
> tables on boot. Once a buffer is requested, a low memory kernel mapping
> is updated to to match requested memory access type.
> 
> GFP_ATOMIC allocations are performed from special pool which is created
> early during boot. This way remapping page attributes is not needed on
> allocation time.
> 
> CMA has been enabled unconditionally for ARMv6+ systems.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Please ignore this patch. The patch named as "[PATCH 8/9] ARM: integrate
CMA with DMA-mapping subsystem" in this thread is the correct one.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
