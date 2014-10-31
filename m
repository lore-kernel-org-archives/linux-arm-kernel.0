From: broonie@kernel.org (Mark Brown)
Date: Fri, 31 Oct 2014 18:11:55 +0000
Subject: [PATCH] ASoC: rockchip-i2s: add rockchip-max98090 driver support
In-Reply-To: <1413938456-30468-1-git-send-email-jay.xu@rock-chips.com>
References: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
 <1413938456-30468-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20141031181155.GP18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 08:40:56AM +0800, Jianqun wrote:

>  config SND_SOC_ROCKCHIP_I2S
>  	tristate
> +	depends on CLKDEV_LOOKUP && SND_SOC_ROCKCHIP
> +	help
> +	  Say Y or M if you want to add support for I2S driver for Rockchip
> +	  I2S device.

You need to make this directlyuser selectable by adding some text after
the tristate as well as the rest.

> +config SND_SOC_MAX98090
> +	tristate "ASoC support max98090 device driver"
> +	depends on I2C && GPIOLIB
> +	select SND_SOC_ROCKCHIP_I2S
> +	help
> +	  Say Y or M here if you want to add support for Rockchio board using
> +	  a max98090 codec.

This needs to modify the existing MAX98090 entry, not duplicate it
(probably as a separate patch).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/4f0bd26b/attachment.sig>
