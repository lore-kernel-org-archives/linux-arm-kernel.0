From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Apr 2013 11:03:20 -0700
Subject: [PATCH 21/21] mtd: omap2: allow bulding as a module
In-Reply-To: <1366734653-488286-22-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-22-git-send-email-arnd@arndb.de>
Message-ID: <20130423180320.GJ10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130423 09:37]:
> The omap2 nand device driver calls into the the elm code, which can
> be a loadable module, and in that case it cannot be built-in itself.
> I can see no reason why the omap2 driver cannot also be a module,
> so let's make the option "tristate" in Kconfig to fix this allmodconfig
> build error:
> 
> ERROR: "elm_config" [drivers/mtd/nand/omap2.ko] undefined!
> ERROR: "elm_decode_bch_error_page" [drivers/mtd/nand/omap2.ko] undefined!
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Afzal Mohammed <afzal@ti.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: linux-mtd at lists.infradead.org
> ---
>  drivers/mtd/nand/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 81bf5e5..106b55e 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -109,7 +109,7 @@ config MTD_NAND_OMAP2
>  
>  config MTD_NAND_OMAP_BCH
>  	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
> -	bool "Enable support for hardware BCH error correction"
> +	tristate "Enable support for hardware BCH error correction"
>  	default n
>  	select BCH
>  	select BCH_CONST_PARAMS

Acked-by: Tony Lindgren <tony@atomide.com>

While at it, you could also drop the "default n" as that's
the default anyways.

Regards,

Tony
