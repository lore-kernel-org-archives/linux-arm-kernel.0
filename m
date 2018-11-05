From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 5 Nov 2018 09:43:04 +0000
Subject: [PATCH] ASoC: sunxi: rename SND_SUNXI_ADDA_PR_REGMAP to
 SND_SUN8I_ADDA_PR_REGMAP
In-Reply-To: <20181103042651.6641-1-anarsoul@gmail.com>
References: <20181103042651.6641-1-anarsoul@gmail.com>
Message-ID: <20181105094304.3ce0d12c@donnerap.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  2 Nov 2018 21:26:51 -0700
Vasily Khoruzhick <anarsoul@gmail.com> wrote:

> SND_SUN50I_CODEC_ANALOG selects SND_SUNXI_ADDA_PR_REGMAP which is
> leftover of renaming SND_SUNXI_ADDA_PR_REGMAP to
> SND_SUN8I_ADDA_PR_REGMAP. Replace it with SND_SUN8I_ADDA_PR_REGMAP to
> fix possible link errors for some configurations:

> 
> sound/soc/sunxi/sun50i-codec-analog.o: In function `sun50i_codec_analog_probe':
> sun50i-codec-analog.c:(.text+0x62): undefined reference to `sun8i_adda_pr_regmap_init'
> 
> Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path controls")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Just stumbled over the same thing when building 4.20-rc1.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre.

---
>  sound/soc/sunxi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 66aad0d3f9c7..8134c3c94229 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -31,7 +31,7 @@ config SND_SUN8I_CODEC_ANALOG
>  config SND_SUN50I_CODEC_ANALOG
>  	tristate "Allwinner sun50i Codec Analog Controls Support"
>  	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> -	select SND_SUNXI_ADDA_PR_REGMAP
> +	select SND_SUN8I_ADDA_PR_REGMAP
>  	help
>  	  Say Y or M if you want to add support for the analog
> controls for the codec embedded in Allwinner A64 SoC.
