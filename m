From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 24 Feb 2014 13:31:15 +0100
Subject: [PATCH] ARM: mvebu: Armada 375/38x depend on MULTI_V7
In-Reply-To: <1393174030-10549-1-git-send-email-jason@lakedaemon.net>
References: <1393174030-10549-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20140224123115.GC18601@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 04:47:10PM +0000, Jason Cooper wrote:
> During this release cycle, we're adding the new Armada 375, 380, and 385
> SoCs.  We're also migrating DT kirkwood boards into mach-mvebu.  The
> kirkwood changes make the different SoCs in mach-mvebu/ depend on
> MULTI_V7 or MULTI_V5 as appropriate.
> 
> We add this dependency to the new SoCs so that when the branches are
> merged, everything is as it should be.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks Jason,

       Andrew

> ---
> Adding this to mvebu/soc-3xx
> 
>  arch/arm/mach-mvebu/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 884b275ab056..00dc4a6ace6e 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -38,7 +38,7 @@ config MACH_ARMADA_370
>  	  on the Marvell Armada 370 SoC with device tree.
>  
>  config MACH_ARMADA_375
> -	bool "Marvell Armada 375 boards"
> +	bool "Marvell Armada 375 boards" if ARCH_MULTI_V7
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_753970
>  	select ARM_GIC
> @@ -52,7 +52,7 @@ config MACH_ARMADA_375
>  	  on the Marvell Armada 375 SoC with device tree.
>  
>  config MACH_ARMADA_38X
> -	bool "Marvell Armada 380/385 boards"
> +	bool "Marvell Armada 380/385 boards" if ARCH_MULTI_V7
>  	select ARM_ERRATA_720789
>  	select ARM_ERRATA_753970
>  	select ARM_GIC
> -- 
> 1.9.0
> 
