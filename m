From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Jan 2017 15:35:03 +0000
Subject: [PATCH] arm64: Add support for DMA_ATTR_SKIP_CPU_SYNC attribute
 to swiotlb
In-Reply-To: <1484129477-24121-1-git-send-email-geert+renesas@glider.be>
References: <1484129477-24121-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170112153503.GD13843@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 11:11:17AM +0100, Geert Uytterhoeven wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch adds support for DMA_ATTR_SKIP_CPU_SYNC attribute for
> dma_{un}map_{page,sg} functions family to swiotlb.
> 
> DMA_ATTR_SKIP_CPU_SYNC allows platform code to skip synchronization of
> the CPU cache for the given buffer assuming that it has been already
> transferred to 'device' domain.
> 
> Ported from IOMMU .{un}map_{sg,page} ops.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add Acked-by.
> 
> Support for DMA_ATTR_SKIP_CPU_SYNC was included when porting the IOMMU
> ops from arm to arm64 in commit 13b8629f651164d7 ("arm64: Add IOMMU
> dma_ops").
> 
> Presumably it was an oversight that the existing swiotlb based
> implementation didn't have support for DMA_ATTR_SKIP_CPU_SYNC yet?
> ---
>  arch/arm64/mm/dma-mapping.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Thanks. Applied for 4.11, with Robin's Reviewed-by.

Will
