From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 06 Nov 2013 12:55:35 +0100
Subject: [alsa-devel] [PATCH 08/13] ASoC: generic-dmaengine-pcm: Clear
 slave_config memory
In-Reply-To: <1383732985-18928-9-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-9-git-send-email-lee.jones@linaro.org>
Message-ID: <527A2E37.2040100@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2013 11:16 AM, Lee Jones wrote:
> We currently assume that the DMA Slave Config will be fully populated
> by the platform, however some DMA Engines make decisions based on zero
> (default) flags such as DMA_SLAVE_BUSWIDTH_UNDEFINED and as this is a
> static declaration we need to memset it to clear the data area.
> 
> Cc: alsa-devel at alsa-project.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  sound/soc/soc-generic-dmaengine-pcm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index ee07903..6ad4c7a 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -90,6 +90,8 @@ static int dmaengine_pcm_hw_params(struct snd_pcm_substream *substream,
>  	struct dma_slave_config slave_config;
>  	int ret;
>  
> +	memset(&slave_config, 0, sizeof(slave_config));
> +
>  	if (!pcm->config)
>  		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
>  	else
> 
