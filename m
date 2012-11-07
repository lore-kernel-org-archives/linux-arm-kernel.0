From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 7 Nov 2012 20:49:07 +0800
Subject: [PATCH] DMAEngine: add dmaengine_prep_interleaved_dma wrapper for
 interleaved api
In-Reply-To: <1352209637-8841-1-git-send-email-21cnbao@gmail.com>
References: <1352209637-8841-1-git-send-email-21cnbao@gmail.com>
Message-ID: <CAGsJ_4xWf+0-Zc0EWPva1tzq74NsT8KC+1SYArZNpBC05PC1+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sorry for the mis-operation of missing Vinod.
attached this patch too.

2012/11/6 Barry Song <21cnbao@gmail.com>:
> From: Barry Song <Baohua.Song@csr.com>
>
> commit b14dab792dee(DMAEngine: Define interleaved transfer request api) adds
> interleaved request api, this patch adds the dmaengine_prep_interleaved_dma
> just like we have dmaengine_prep_ for other modes to avoid drivers call:
> xxx_chan->device->device_prep_interleaved_dma().
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  include/linux/dmaengine.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index d3201e4..135bbb5 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -660,6 +660,13 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_cyclic(
>                                                 period_len, dir, flags, NULL);
>  }
>
> +static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
> +               struct dma_chan *chan, struct dma_interleaved_template *xt,
> +               unsigned long flags)
> +{
> +       return chan->device->device_prep_interleaved_dma(chan, xt, flags);
> +}
> +
>  static inline int dmaengine_terminate_all(struct dma_chan *chan)
>  {
>         return dmaengine_device_control(chan, DMA_TERMINATE_ALL, 0);
> --
> 1.7.1

-barry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-DMAEngine-add-dmaengine_prep_interleaved_dma-wrapper.patch
Type: application/octet-stream
Size: 1388 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121107/cae286bf/attachment-0001.obj>
