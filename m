From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 11 Oct 2012 09:55:25 +0800
Subject: [PATCH 1/3] dmaengine: sirf: fix a typo in dma_prep_interleaved
In-Reply-To: <1348734938-20014-1-git-send-email-Barry.Song@csr.com>
References: <1348734938-20014-1-git-send-email-Barry.Song@csr.com>
Message-ID: <CAGsJ_4yeztpGDRmFzh=ebbx0Eka2+s9DSasFf9r6kucivnBJ3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping

2012/9/27 Barry Song <Barry.Song@csr.com>:
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
>         unsigned long iflags;
>         int ret;
>
> -       if ((xt->dir != DMA_MEM_TO_DEV) || (xt->dir != DMA_DEV_TO_MEM)) {
> +       if ((xt->dir != DMA_MEM_TO_DEV) && (xt->dir != DMA_DEV_TO_MEM)) {
>                 ret = -EINVAL;
>                 goto err_dir;
>         }
> --
> 1.7.0.4
>
