From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 27 Sep 2015 20:12:06 -0700
Subject: [PATCH 1/1] dmaengine: dw: fix nollp issue
In-Reply-To: <032901d0f999$363fae80$a2bf0b80$@tangramtek.com>
References: <032901d0f999$363fae80$a2bf0b80$@tangramtek.com>
Message-ID: <CAOh2x=n8=-BeUTJFaTA3Jkv94OYe9J1-BF=CTRHm--s2NjspeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2015 at 7:55 PM, yitian <yitian.bu@tangramtek.com> wrote:
> when channel number is less than maximum number, the register
> address of all channels is wrong, which causes the "nollp" flag
> is set for all channels even if HW supports llp.
>
> Signed-off-by: Yitian Bu <yitian.bu@tangramtek.com>
> ---
>  drivers/dma/dw/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index cf1c87f..c2e9ac8 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -1591,7 +1591,7 @@ int dw_dma_probe(struct dw_dma_chip *chip, struct
> dw_dma_platform_data *pdata)
>         INIT_LIST_HEAD(&dw->dma.channels);
>         for (i = 0; i < nr_channels; i++) {
>                 struct dw_dma_chan      *dwc = &dw->chan[i];
> -               int                     r = nr_channels - i - 1;
> +               int                     r = DW_DMA_MAX_NR_CHANNELS - i - 1;
>
>                 dwc->chan.device = &dw->dma;
>                 dma_cookie_init(&dwc->chan);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
