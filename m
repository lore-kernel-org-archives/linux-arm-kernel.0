From: vkoul@infradead.org (Vinod Koul)
Date: Wed, 24 Oct 2012 16:33:23 +0530
Subject: [PATCH 1/3] dmaengine: sirf: fix a typo in dma_prep_interleaved
In-Reply-To: <1348734938-20014-1-git-send-email-Barry.Song@csr.com>
References: <1348734938-20014-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1351076603.5263.57.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-09-27 at 16:35 +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> either DEV_TO_MEM or MEM_TO_DEV is supported, so change
> OR to AND.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/dma/sirf-dma.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
> index 434ad31..35a329d 100644
> --- a/drivers/dma/sirf-dma.c
> +++ b/drivers/dma/sirf-dma.c
> @@ -428,7 +428,7 @@ static struct dma_async_tx_descriptor *sirfsoc_dma_prep_interleaved(
>  	unsigned long iflags;
>  	int ret;
>  
> -	if ((xt->dir != DMA_MEM_TO_DEV) || (xt->dir != DMA_DEV_TO_MEM)) {
> +	if ((xt->dir != DMA_MEM_TO_DEV) && (xt->dir != DMA_DEV_TO_MEM)) {
>  		ret = -EINVAL;
>  		goto err_dir;
>  	}

applied thanks
-- 
Vinod Koul
Intel Corp.
