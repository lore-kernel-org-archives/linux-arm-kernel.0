From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 May 2014 18:42:24 -0300
Subject: [PATCH] dma: imx: correct sdmac->status for cyclic dma tx
In-Reply-To: <1386913966-20595-1-git-send-email-jiada_wang@mentor.com>
References: <1386913966-20595-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <CAOMZO5Ad5ZvpozNtR+i9FZvKpgcsxOoCp5mDx9WbBnc1Qtu8Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jiada,

On Fri, Dec 13, 2013 at 3:52 AM,  <jiada_wang@mentor.com> wrote:
> From: Jiada Wang <jiada_wang@mentor.com>
>
> In cyclic dma tx's handler sdma_handle_channel_loop(),
> SDMA channel statue is set to either DMA_ERROR or DMA_IN_PROGRESS
> based on each period's status. This has the following issues:
>
> 1) If one period's status is BD_RROR, then channel status
>    will be set to DMA_ERROR, but it will be overwritten to DMA_IN_PROGRESS
>    if the following periods are OK.
> 2) DMA client may call sdma_control(DMA_TERMINATE_ALL) to stop the cyclic dma
>    operation, sdma channel status will be set to DMA_ERROR,
>    but if after this handler is called, then again the channel status will be overwritten
>    to DMA_IN_PROGRESS. Then the following dmaengine_prep_dma_cyclic() will always fail,
>    as channel status is DMA_IN_PROGRESS.
>
> As in cyclic dma tx, channel status will be initially set to DMA_IN_PROGRESS,
> driver only needs to change it to DMA_ERROR, when something wrong happens
> (one period status is wrong, or stoped by client explicitly).
>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

It seems this one got lost as you did not put the dma maintainer on Cc.

Please run ./scripts/get_maintainer.pl and re-submit it.
