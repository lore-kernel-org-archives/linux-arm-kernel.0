From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 31 Aug 2012 10:41:36 -0700
Subject: [PATCH] ASoC: samsung dma - Don't indicate support for
 pause/resume.
In-Reply-To: <1346387854-22222-1-git-send-email-dgreid@chromium.org>
References: <1346387854-22222-1-git-send-email-dgreid@chromium.org>
Message-ID: <20120831174135.GF25575@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 09:37:34PM -0700, Dylan Reid wrote:

> index f3ebc38..56a507a 100644
> --- a/sound/soc/samsung/dma.c
> +++ b/sound/soc/samsung/dma.c
> @@ -34,9 +34,7 @@ static const struct snd_pcm_hardware dma_hardware = {
>  	.info			= SNDRV_PCM_INFO_INTERLEAVED |
>  				    SNDRV_PCM_INFO_BLOCK_TRANSFER |
>  				    SNDRV_PCM_INFO_MMAP |
> -				    SNDRV_PCM_INFO_MMAP_VALID |
> -				    SNDRV_PCM_INFO_PAUSE |
> -				    SNDRV_PCM_INFO_RESUME,
> +				    SNDRV_PCM_INFO_MMAP_VALID,

I'd expect to also see an update to the trigger function to not accept
the suspend and resume triggers?
