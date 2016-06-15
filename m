From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 15 Jun 2016 18:58:42 +0800
Subject: [alsa-devel] [PATCH v4 9/9] ASoC: mediatek: Add mt2701-cs42448
 driver and config option.
In-Reply-To: <1465802806-19197-10-git-send-email-garlic.tseng@mediatek.com>
References: <1465802806-19197-1-git-send-email-garlic.tseng@mediatek.com>
 <1465802806-19197-10-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1465988322.30493.7.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-13 at 15:26 +0800, Garlic Tseng wrote:
> Add machine driver and config option for MT2701.
> 
> Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
> ---
>  sound/soc/mediatek/Kconfig                 |  21 ++
>  sound/soc/mediatek/Makefile                |   1 +
>  sound/soc/mediatek/mt2701/Makefile         |  19 ++
>  sound/soc/mediatek/mt2701/mt2701-cs42448.c | 422 +++++++++++++++++++++++++++++
>  4 files changed, 463 insertions(+)
>  create mode 100644 sound/soc/mediatek/mt2701/Makefile
>  create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index ff1a419..0ecb785 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -7,6 +7,27 @@ config SND_SOC_MEDIATEK
>  	  Select Y if you have such device.
>  	  If unsure select "N".
>  
> +config SND_SOC_MT2701
> +	tristate "ASoC support for Mediatek MT2701 chip"
> +	depends on ARCH_MEDIATEK
> +	select SND_SOC_MEDIATEK
> +	help
> +	  This adds ASoC driver for Mediatek MT2701 boards
> +	  that can be used with other codecs.
> +	  Select Y if you have such device.
> +	  If unsure select "N".
> +
> +config SND_SOC_MT2701_CS42448
> +	tristate "SND_SOC_MT2701_CS42448"

Please provide proper config prompt here.

Joe.C
