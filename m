From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Jan 2015 11:41:34 +0000
Subject: [PATCH] ASoC: Samsung: add missing I2C/SPI dependencies
In-Reply-To: <1815674.ObkQWLfgIW@wuerfel>
References: <1815674.ObkQWLfgIW@wuerfel>
Message-ID: <20150129114134.GC21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 10:28:55PM +0100, Arnd Bergmann wrote:
> The SND_SOC_ARNDALE_RT5631_ALC5631 selects the rt5631 codec
> that requires I2C to work, so we get a build error if I2C
> is disabled:

You rather buried the lead about there being other drivers in this
changelog, makes the code a bit surprising when you find it.

>  config SND_SOC_SPEYSIDE
>  	tristate "Audio support for Wolfson Speyside"
> -	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
> +	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410 && SPI_MASTER
>  	select SND_SAMSUNG_I2S
>  	select SND_SOC_WM8996
>  	select SND_SOC_WM9081

Why only add a dependency on SPI here?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150129/740b01cf/attachment-0001.sig>
