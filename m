From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 15:05:34 -0800
Subject: [PATCH 2/2] omap: build am3517crane board support by default
In-Reply-To: <1328818586-7104-3-git-send-email-mporter@ti.com>
References: <1328818586-7104-1-git-send-email-mporter@ti.com>
 <1328818586-7104-3-git-send-email-mporter@ti.com>
Message-ID: <20120305230534.GN12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matt Porter <mporter@ti.com> [120209 11:49]:
> Set default to include support for the craneboard when
> using the omap2plus_defconfig.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index d965da4..678b8ac 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -206,6 +206,7 @@ config MACH_OMAP3517EVM
>  config MACH_CRANEBOARD
>  	bool "AM3517/05 CRANE board"
>  	depends on ARCH_OMAP3
> +	default y
>  	select OMAP_PACKAGE_CBB
>  
>  config MACH_OMAP3_PANDORA

As you may have read, we should remove the "default y"
from Kconfig. So can you please update your first patch in this
series to set CONFIG_MACH_CRANEBOARD=y in omap2plus_defconfig?

Thanks,

Regards,

Tony
