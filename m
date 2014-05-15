From: linux@baker-net.org.uk (Adam Baker)
Date: Thu, 15 May 2014 23:01:14 +0100
Subject: [PATCH RFC 03/11] sound: ASoC: kirkwood: Remove ARCH_KIRKWOOD
 dependency
In-Reply-To: <1400163836-9831-7-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
 <1400163836-9831-7-git-send-email-andrew@lunn.ch>
Message-ID: <5375392A.60905@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/14 15:23, Andrew Lunn wrote:
> mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.

Most of the descriptions in the series say remove mach-kirkwood and most 
of the actual patches remove ARCH_KIRKWOOD and leave MACH_KIRKWOOD 
untouched. Patch 01/11 hasn't turned up here so I'm not certain which 
you meant but consistency would be good.

>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel at alsa-project.org
> ---
>   sound/soc/kirkwood/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
> index 1f7c7ee3527a..6a0f79d2bb33 100644
> --- a/sound/soc/kirkwood/Kconfig
> +++ b/sound/soc/kirkwood/Kconfig
> @@ -1,6 +1,6 @@
>   config SND_KIRKWOOD_SOC
>   	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
> -	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU || MACH_KIRKWOOD || COMPILE_TEST
> +	depends on ARCH_DOVE || ARCH_MVEBU || MACH_KIRKWOOD || COMPILE_TEST
>   	help
>   	  Say Y or M if you want to add support for codecs attached to
>   	  the Kirkwood I2S interface. You will also need to select the
>

Regards

Adam Baker
