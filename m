From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 13 May 2013 16:54:05 -0300
Subject: [PATCH] ARM: sunxi: select ARCH_REQUIRE_GPIOLIB
In-Reply-To: <1368435188-26965-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368435188-26965-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <519144DD.1090101@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 13/05/13 05:53, Maxime Ripard escribi?:
> CONFIG_SUNXI currently doesn't enable a gpiolib, which causes build
> problems when building a kernel with only the sunxi platform enabled.
> Select ARCH_REQUIRE_GPIOLIB to solve this.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-sunxi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index d259c78..5b045e3 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -1,5 +1,6 @@
>  config ARCH_SUNXI
>  	bool "Allwinner A1X SOCs" if ARCH_MULTI_V7
> +	select ARCH_REQUIRE_GPIOLIB
>  	select CLKSRC_MMIO
>  	select CLKSRC_OF
>  	select COMMON_CLK
> 

Tested-by: Emilio L?pez <emilio@elopez.com.ar>

This fixes the build breakage I was seeing.

Thanks!

Emilio
