From: lrg@ti.com (Liam Girdwood)
Date: Mon, 22 Aug 2011 11:37:53 +0100
Subject: [PATCH 2/2] ASoC: mxs-sgtl5000: add record function
In-Reply-To: <1313942566-21433-1-git-send-email-b29396@freescale.com>
References: <1313942566-21433-1-git-send-email-b29396@freescale.com>
Message-ID: <4E523181.1020903@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/08/11 17:02, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  sound/soc/mxs/mxs-sgtl5000.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
> index a0d89c9..7fbeaec 100644
> --- a/sound/soc/mxs/mxs-sgtl5000.c
> +++ b/sound/soc/mxs/mxs-sgtl5000.c
> @@ -85,13 +85,21 @@ static struct snd_soc_ops mxs_sgtl5000_hifi_ops = {
>  
>  static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
>  	{
> -		.name		= "HiFi",
> +		.name		= "HiFi Tx",
>  		.stream_name	= "HiFi Playback",
>  		.codec_dai_name	= "sgtl5000",
>  		.codec_name	= "sgtl5000.0-000a",
>  		.cpu_dai_name	= "mxs-saif.0",
>  		.platform_name	= "mxs-pcm-audio.0",
>  		.ops		= &mxs_sgtl5000_hifi_ops,
> +	}, {
> +		.name		= "HiFi Rx",
> +		.stream_name	= "HiFi Capture",
> +		.codec_dai_name	= "sgtl5000",
> +		.codec_name	= "sgtl5000.0-000a",
> +		.cpu_dai_name	= "mxs-saif.1",
> +		.platform_name	= "mxs-pcm-audio.1",
> +		.ops		= &mxs_sgtl5000_hifi_ops,
>  	},
>  };
>  

Acked-by: Liam Girdwood <lrg@ti.com>
