From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 13 Jun 2012 20:52:51 +0200
Subject: [Linaro-mm-sig] [PATCHv2 3/6] common: dma-mapping: introduce
 dma_get_sgtable() function
In-Reply-To: <1339588218-24398-4-git-send-email-m.szyprowski@samsung.com>
References: <1339588218-24398-1-git-send-email-m.szyprowski@samsung.com>
 <1339588218-24398-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120613185251.GN4829@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 01:50:15PM +0200, Marek Szyprowski wrote:
> This patch adds dma_get_sgtable() function which is required to let
> drivers to share the buffers allocated by DMA-mapping subsystem. Right
> now the driver gets a dma address of the allocated buffer and the kernel
> virtual mapping for it. If it wants to share it with other device (= map
> into its dma address space) it usually hacks around kernel virtual
> addresses to get pointers to pages or assumes that both devices share
> the DMA address space. Both solutions are just hacks for the special
> cases, which should be avoided in the final version of buffer sharing.
> 
> To solve this issue in a generic way, a new call to DMA mapping has been
> introduced - dma_get_sgtable(). It allocates a scatter-list which
> describes the allocated buffer and lets the driver(s) to use it with
> other device(s) by calling dma_map_sg() on it.
> 
> This patch provides a generic implementation based on virt_to_page()
> call. Architectures which require more sophisticated translation might
> provide their own get_sgtable() methods.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-- 
Daniel Vetter
Mail: daniel at ffwll.ch
Mobile: +41 (0)79 365 57 48
