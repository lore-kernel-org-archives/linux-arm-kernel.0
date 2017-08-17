From: bgoswami@codeaurora.org (Banajit Goswami)
Date: Thu, 17 Aug 2017 00:59:29 -0700
Subject: [PATCH 07/11] ASoC: qcom: make snd_soc_platform_driver const
In-Reply-To: <1502710730-18912-8-git-send-email-bhumirks@gmail.com>
References: <1502710730-18912-1-git-send-email-bhumirks@gmail.com>
 <1502710730-18912-8-git-send-email-bhumirks@gmail.com>
Message-ID: <20170817075929.GA11689@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 04:38:46AM -0700, Bhumika Goyal wrote:
> Make this const as it is only passed as the 2nd argument to the
> function devm_snd_soc_register_platform, which is of type const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

> ---
>  sound/soc/qcom/lpass-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/lpass-platform.c
> b/sound/soc/qcom/lpass-platform.c
> index 7aabf08..fb3576a 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -557,7 +557,7 @@ static void lpass_platform_pcm_free(struct snd_pcm
> *pcm)
>  	}
>  }
>  
> -static struct snd_soc_platform_driver lpass_platform_driver = {
> +static const struct snd_soc_platform_driver lpass_platform_driver = {
>  	.pcm_new	= lpass_platform_pcm_new,
>  	.pcm_free	= lpass_platform_pcm_free,
>  	.ops		= &lpass_platform_pcm_ops,
> -- 
> 1.9.1
> 
