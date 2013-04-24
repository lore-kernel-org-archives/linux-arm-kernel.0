From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Apr 2013 21:45:40 +0200
Subject: [PATCH v5 01/10] ASoC: phycore-ac97: Add DT support
In-Reply-To: <1366814199-14827-2-git-send-email-mpa@pengutronix.de>
References: <1366814199-14827-1-git-send-email-mpa@pengutronix.de>
 <1366814199-14827-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20130424194540.GF32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Wed, Apr 24, 2013 at 04:36:30PM +0200, Markus Pargmann wrote:
> Add devicetree support for this audio soc fabric driver.
> 
> @@ -32,8 +35,12 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
>  		.stream_name	= "HiFi",
>  		.codec_dai_name		= "wm9712-hifi",
>  		.codec_name	= "wm9712-codec",
> +#ifdef CONFIG_MACH_IMX27_DT
> +		.platform_name	= "imx-fiq-pcm-audio",
> +#else
>  		.cpu_dai_name	= "imx-ssi.0",
>  		.platform_name	= "imx-fiq-pcm-audio.0",
> +#endif

This doesn't work properly. Compiling the kernel with IMX27_DT enabled
does not necessarily mean that it also started with dt support.

Personally I am fine with removing platform based support for this
driver if it's too much effort to fix it properly, but we shouldn't
start working with ifdefs here.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
