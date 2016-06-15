From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 15 Jun 2016 18:57:22 +0800
Subject: [alsa-devel] [PATCH v4 3/9] ASoC: mediatek: let mt8173 use
 mediatek common structure
In-Reply-To: <1465802806-19197-4-git-send-email-garlic.tseng@mediatek.com>
References: <1465802806-19197-1-git-send-email-garlic.tseng@mediatek.com>
 <1465802806-19197-4-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1465988242.30493.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-13 at 15:26 +0800, Garlic Tseng wrote:
> Modify mt8173 driver implementation to use common structure.
> 
> Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
> ---
>  sound/soc/mediatek/Kconfig                    |  11 +
>  sound/soc/mediatek/Makefile                   |   3 +-
>  sound/soc/mediatek/common/Makefile            |  17 +
>  sound/soc/mediatek/mt8173/mt8173-afe-common.h |  42 +-
>  sound/soc/mediatek/mt8173/mt8173-afe-pcm.c    | 679 +++++++++++---------------
>  5 files changed, 327 insertions(+), 425 deletions(-)
>  create mode 100644 sound/soc/mediatek/common/Makefile
> 
> diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
> index ae9f664..ff1a419 100644
> --- a/sound/soc/mediatek/Kconfig
> +++ b/sound/soc/mediatek/Kconfig
> @@ -1,6 +1,16 @@
> +config SND_SOC_MEDIATEK
> +	tristate "SND_SOC_MEDIATEK"
> +	depends on ARCH_MEDIATEK
> +	help
> +	  This adds ASoC driver for Mediatek boards
> +	  that can be used with other codecs.
> +	  Select Y if you have such device.
> +	  If unsure select "N".
> +
>  config SND_SOC_MT8173
>  	tristate "ASoC support for Mediatek MT8173 chip"
>  	depends on ARCH_MEDIATEK
> +	select SND_SOC_MEDIATEK
>  	help
>  	  This adds ASoC platform driver support for Mediatek MT8173 chip
>  	  that can be used with other codecs.

It seems both SND_SOC_MT8173 and SND_SOC_MT2701 select SND_SOC_MEDIATEK,
and enabling only SND_SOC_MEDIATEK itself is not really useful. Do we
need to make SND_SOC_MEDIATEK user configurable option?

If it is, we should at least have a proper config prompt instead of just
"SND_SOC_MEDIATEK".


> @@ -49,3 +59,4 @@ config SND_SOC_MT8173_RT5650_RT5676
>  	  with the RT5650 and RT5676 codecs.
>  	  Select Y if you have such device.
>  	  If unsure select "N".
> +

nit: This change is not necessary.

Joe.C
