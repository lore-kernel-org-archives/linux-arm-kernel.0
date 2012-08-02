From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 2 Aug 2012 13:21:03 +0100
Subject: [PATCH 1/6] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20120802122101.GA22228@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch withdrawn.

On Tue, Jul 31, 2012 at 02:31:23PM +0100, Lee Jones wrote:
> If a list of widgets is provided and one of them fails to be added as
> a control, the present semantics fail all subsequent widgets. A better
> solution would be to only fail that widget, but pursue in attempting
> to add the rest of the list.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  sound/soc/soc-dapm.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index eded657..7d9c154 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3095,8 +3095,6 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
>  			dev_err(dapm->dev,
>  				"ASoC: Failed to create DAPM control %s\n",
>  				widget->name);
> -			ret = -ENOMEM;
> -			break;
>  		}
>  		widget++;
>  	}
> -- 
> 1.7.9.5
> 

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
