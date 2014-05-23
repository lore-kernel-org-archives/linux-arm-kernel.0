From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 23 May 2014 08:40:32 +0530
Subject: [PATCH] sound: soc: samsung: dma.c: Fix to remove null pointer
 checks that could never happen
In-Reply-To: <1400790060-10977-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1400790060-10977-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <CAHbNUh0cdV3-o+gQaKF3xKH77SRQLJkLGJTr660Bze8kQNDUfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 May 2014 01:51, Rickard Strandqvist
<rickard_strandqvist@spectrumdigital.se> wrote:
> Removal of null pointer checks that could never happen
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---

The subject should probably be (at least should start with "ASoC: samsung:")
"ASoC: samsung: Remove redundant null pointer check from dma.c"

With that change,
Reviewed-by: Tushar Behera <tushar.behera@linaro.org>

>  sound/soc/samsung/dma.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
> index dc09b71..0f17ae0 100644
> --- a/sound/soc/samsung/dma.c
> +++ b/sound/soc/samsung/dma.c
> @@ -124,8 +124,7 @@ static void audio_buffdone(void *data)
>                 if (prtd->dma_pos >= prtd->dma_end)
>                         prtd->dma_pos = prtd->dma_start;
>
> -               if (substream)
> -                       snd_pcm_period_elapsed(substream);
> +               snd_pcm_period_elapsed(substream);
>
>                 spin_lock(&prtd->lock);
>                 if (!samsung_dma_has_circular()) {
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Tushar Behera
