From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 30 Nov 2015 16:35:31 +0200
Subject: [RFC v02 01/15] dmaengine: core: Allow NULL mask pointer in
 __dma_device_satisfies_mask()
In-Reply-To: <1448891145-10766-2-git-send-email-peter.ujfalusi@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <CAHp75VfY=NU4MG7q1w=oYdTiTr0dqtNTQU3UkEaL=tXPJADH5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 3:45 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Treat as true condition the case when the mask is NULL.

What do you think about setting some default (all "on") mask when mask
is not supplied?

I don't know for sure but there might be cases when you don't want
literally *any* channel to satisfy.

>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/dmaengine.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index daf54a39bcc7..52c3eee48e2e 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -184,6 +184,9 @@ __dma_device_satisfies_mask(struct dma_device *device,
>  {
>         dma_cap_mask_t has;
>
> +       if (!want)
> +               return true;
> +
>         bitmap_and(has.bits, want->bits, device->cap_mask.bits,
>                 DMA_TX_TYPE_END);
>         return bitmap_equal(want->bits, has.bits, DMA_TX_TYPE_END);
> --
> 2.6.3
>



-- 
With Best Regards,
Andy Shevchenko
