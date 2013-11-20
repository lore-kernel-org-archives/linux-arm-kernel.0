From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 20 Nov 2013 14:57:34 -0300
Subject: [RFC] mtd: gpmc: add BCH support for plain AM335x
In-Reply-To: <1384969152-10411-1-git-send-email-wsa@the-dreams.de>
References: <1384969152-10411-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20131120175733.GA27064@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Wolfram:

On Wed, Nov 20, 2013 at 06:39:12PM +0100, Wolfram Sang wrote:
> When building a kernel without OMAP3 support but only AM335x, we can't
> activate the needed MTD_NAND_OMAP_BCH symbol.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> 
> Actually, I wonder if this is fix will scale. Maybe someone with more insight
> about TI SoCs could find a better expression of supported SoCs. This is the
> only one I could test .
> 
>  drivers/mtd/nand/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 93ae6a6..f9455e4 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -95,7 +95,7 @@ config MTD_NAND_OMAP2
>  	  platforms.
>  
>  config MTD_NAND_OMAP_BCH
> -	depends on MTD_NAND && MTD_NAND_OMAP2 && ARCH_OMAP3
> +	depends on MTD_NAND && MTD_NAND_OMAP2 && (ARCH_OMAP3 || SOC_AM33XX)
>  	tristate "Support hardware based BCH error correction"
>  	default n
>  	select BCH
> -- 
> 1.8.4.2
> 

A similar patch has been already merged and you can pick it from l2-mtd
next branch:

http://git.infradead.org/l2-mtd.git/commitdiff/1900cdf03057030497e967614c4b19296b6ac460

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
