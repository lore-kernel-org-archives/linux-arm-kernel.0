From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 26 Sep 2018 16:52:40 +0200
Subject: [PATCH] [v2] ARM: omap1: add nand_chip declaration
In-Reply-To: <20180926142029.619397-1-arnd@arndb.de>
References: <20180926142029.619397-1-arnd@arndb.de>
Message-ID: <20180926165240.77a78fc4@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> wrote on Wed, 26 Sep 2018 16:20:16 +0200:

> Recent MTD changes caused a minor build regression on OMAP1:
> 
> In file included from arch/arm/mach-omap1/devices.c:31:
> arch/arm/mach-omap1/common.h:85:39: error: 'struct nand_chip' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> 
> Fixes: 1002aed789bc ("mtd: rawnand: plat_nand: Pass a nand_chip object to all platform_nand_ctrl hooks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> v2: remove unused linux/mtd/mtd.h inclusion
> ---
>  arch/arm/mach-omap1/common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
> index 11b87a4c84d4..504b959ba5cf 100644
> --- a/arch/arm/mach-omap1/common.h
> +++ b/arch/arm/mach-omap1/common.h
> @@ -26,7 +26,6 @@
>  #ifndef __ARCH_ARM_MACH_OMAP1_COMMON_H
>  #define __ARCH_ARM_MACH_OMAP1_COMMON_H
>  
> -#include <linux/mtd/mtd.h>
>  #include <linux/platform_data/i2c-omap.h>
>  #include <linux/reboot.h>
>  
> @@ -82,6 +81,7 @@ void omap1_restart(enum reboot_mode, const char *);
>  
>  extern void __init omap_check_revision(void);
>  
> +struct nand_chip;
>  extern void omap1_nand_cmd_ctl(struct nand_chip *this, int cmd,
>  			       unsigned int ctrl);
>  

Boris pointed me that the commit introducing the regression is still
in nand/next, so do you mind if I squash both patches with it?

Regards,
Miqu?l
