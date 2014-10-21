From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 21 Oct 2014 14:39:09 +0200
Subject: [alsa-devel] [PATCH] ASoC: rockchip-i2s: add rockchip-max98090
 driver support
In-Reply-To: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
References: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <544653ED.8000304@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2014 01:31 PM, Jianqun wrote:
> This patch is to add support for rockchip board with max98090 codec.
> It also needs sound node in dt file.
>
> Tested on rockchip board based on rk3288.
>
> Signed-off-by: Jianqun <jay.xu@rock-chips.com>
> ---
>   sound/soc/rockchip/Kconfig | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
> index 78fc159..482cbba 100644
> --- a/sound/soc/rockchip/Kconfig
> +++ b/sound/soc/rockchip/Kconfig
> @@ -9,3 +9,16 @@ config SND_SOC_ROCKCHIP
>
>   config SND_SOC_ROCKCHIP_I2S
>   	tristate
> +	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
> +	help
> +	  Say Y or M if you want to add support for I2S driver for Rockchip
> +	  I2S device.
> +
> +config SND_SOC_ROCKCHIP_MAX98090
> +	tristate "ASoC support Rockchip board with max98090"
> +	depends on I2C && GPIOLIB
> +	select SND_SOC_ROCKCHIP_I2S
> +	select SND_SOC_MAX98090
> +	help
> +	  Say Y or M here if you want to add support for Rockchio board using
> +	  a max98090 codec.
>

Just make the max98090 driver directly selectable. That's what we typically 
do for DT based designs.

- Lars
