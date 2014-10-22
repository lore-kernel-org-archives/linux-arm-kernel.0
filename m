From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 Oct 2014 11:49:47 +0100
Subject: [PATCH v3] ASoC: rockchip-i2s: add MAX98090 support to Kconfig
In-Reply-To: <1413946799-20834-1-git-send-email-jay.xu@rock-chips.com>
References: <1413891110-21059-1-git-send-email-jay.xu@rock-chips.com>
 <1413946799-20834-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20141022104947.GP2344@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 10:59:59AM +0800, Jianqun wrote:

> +config SND_SOC_MAX98090
> +	tristate "ASoC support for max98090 driver"
> +	depends on I2C && GPIOLIB
> +	help
> +	  Say Y or M here if you want to add support for max98090 codec.

No, you're missing what Lars was saying here - there's already a Kconfig
symbol for the CODEC in the codecs directory, you should add the help
text to that in order to allow the user to enable it.  Do this in a
separate patch to making your I2S driver selectable since it's not
directly related code wise.

Please also drop the "ASoC" -> "SoC audio" transition or at least make
it a separate patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141022/2bb10004/attachment.sig>
