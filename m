From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 15 Oct 2018 10:24:00 +0200
Subject: [PATCH v2 3/9] ASoC: sun8i-codec-analog: split regmap code into
 separate driver
In-Reply-To: <20181013165329.13363-4-anarsoul@gmail.com>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-4-anarsoul@gmail.com>
Message-ID: <20181015082400.kapwi475pievgbry@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 13, 2018 at 09:53:23AM -0700, Vasily Khoruzhick wrote:
> It will be reused by sun50i-codec-analog later.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/sunxi/Kconfig                |   7 +-
>  sound/soc/sunxi/Makefile               |   1 +
>  sound/soc/sunxi/sun8i-codec-analog.c   |  79 +------------------
>  sound/soc/sunxi/sunxi-adda-pr-regmap.c | 102 +++++++++++++++++++++++++
>  sound/soc/sunxi/sunxi-adda-pr-regmap.h |   7 ++
>  5 files changed, 119 insertions(+), 77 deletions(-)
>  create mode 100644 sound/soc/sunxi/sunxi-adda-pr-regmap.c
>  create mode 100644 sound/soc/sunxi/sunxi-adda-pr-regmap.h
> 
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 22408bc2d6ec..3932f0238add 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -23,7 +23,7 @@ config SND_SUN8I_CODEC
>  config SND_SUN8I_CODEC_ANALOG
>  	tristate "Allwinner sun8i Codec Analog Controls Support"
>  	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> -	select REGMAP
> +	select SND_SUNXI_ADDA_PR_REGMAP
>  	help
>  	  Say Y or M if you want to add support for the analog controls for
>  	  the codec embedded in newer Allwinner SoCs.
> @@ -45,4 +45,9 @@ config SND_SUN4I_SPDIF
>  	help
>  	  Say Y or M to add support for the S/PDIF audio block in the Allwinner
>  	  A10 and affiliated SoCs.
> +
> +config SND_SUNXI_ADDA_PR_REGMAP
> +	tristate
> +	select REGMAP
> +

This is just a minor nitpick, but I'd rename it to
SND_SUN8I_CODEC_ADDA, to be consistent with the rest of the
drivers/Kconfig symbols.

With that fixed,
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/f6a665cd/attachment.sig>
