From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Dec 2010 09:37:12 -0800
Subject: [PATCH 2/2] arm: mach-omap2: Kconfig: devkit8000 should select
	needed options
In-Reply-To: <1292417352-18082-2-git-send-email-aaro.koskinen@nokia.com>
References: <1292417352-18082-1-git-send-email-aaro.koskinen@nokia.com>
	<1292417352-18082-2-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <20101215173709.GB8406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aaro,

* Aaro Koskinen <aaro.koskinen@nokia.com> [101215 04:48]:
> It's not possible to compile a kernel for this board without I2C,
> MFD_SUPPORT and TWL4030_CORE, so those should be selected. This will
> prevent build errors when trying out different configurations.

This one I'm not so convinced about. We should be able to compile
support for each board and enable and disable these kind of options
just fine if CONFIG_ARCH_OMAP2PLUS_TYPICAL is disabled.

In the long run we really want to have just a minimal kernel
and have everything else as modules for the default configs
and boot using initramfs.

Probably the best way to deal with issues like this is to
have omap generic platform init code for the common devices
that gets built if those options are selected. Otherwise
we'll end up with ifdefs all over the board-*.c files.

Regards,

Tony
 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index db20351..bb32f35 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -129,6 +129,10 @@ config MACH_DEVKIT8000
>  	default y
>  	select OMAP_PACKAGE_CUS
>  	select OMAP_MUX
> +	select I2C
> +	select I2C_OMAP
> +	select MFD_SUPPORT
> +	select TWL4030_CORE
>  
>  config MACH_OMAP_LDP
>  	bool "OMAP3 LDP board"
> -- 
> 1.5.6.5
> 
