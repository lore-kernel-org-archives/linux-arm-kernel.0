From: timur@tabi.org (Timur Tabi)
Date: Mon, 17 Jun 2013 06:39:55 -0500
Subject: [PATCH v8 02/11] ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
In-Reply-To: <1371389117-19729-3-git-send-email-mpa@pengutronix.de>
References: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
 <1371389117-19729-3-git-send-email-mpa@pengutronix.de>
Message-ID: <51BEF58B.8070405@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
>   #ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
> -int imx_pcm_fiq_init(struct platform_device *pdev);
> +int imx_pcm_fiq_init(struct platform_device *pdev,
> +		struct imx_pcm_fiq_params *params);
>   void imx_pcm_fiq_exit(struct platform_device *pdev);
>   #else
> -static inline int imx_pcm_fiq_init(struct platform_device *pdev)
> +static inline int imx_pcm_fiq_init(struct platform_device *pdev,
> +		struct imx_pcm_fiq_params *params);
>   {
>   	return -ENODEV;
>   }

This won't compile on PowerPC, because of the ;

In file included from 
/home/b04825/git/linux.alsa2/sound/soc/fsl/fsl_ssi.c:53:0:
/home/b04825/git/linux.alsa2/sound/soc/fsl/imx-pcm.h:65:1: error: expected 
identifier or '(' before '{' token
/home/b04825/git/linux.alsa2/sound/soc/fsl/imx-pcm.h:63:19: warning: 
'imx_pcm_fiq_init' used but never defined


-- 
Timur Tabi
