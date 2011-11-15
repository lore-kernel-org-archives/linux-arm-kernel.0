From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Nov 2011 17:52:20 +0000
Subject: [PATCH] MTD: nand: Making  MTD_NAND_OMAP2 depend on ARCH_OMAP2PLUS
In-Reply-To: <1321352556-7080-1-git-send-email-shubhrajyoti@ti.com>
References: <1321352556-7080-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20111115175220.GA11274@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 03:52:36PM +0530, Shubhrajyoti D wrote:
> Making  MTD_NAND_OMAP2 depend on ARCH_OMAP2PLUS instead of
> oring with ARCH2/3/4.
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>

Thanks, but please make this rmk+kernel at arm.linux.org.uk.

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/mtd/nand/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index cce7b70..b68dd5e 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -110,7 +110,7 @@ config MTD_NAND_AMS_DELTA
>  
>  config MTD_NAND_OMAP2
>  	tristate "NAND Flash device on OMAP2, OMAP3 and OMAP4"
> -	depends on ARM && (ARCH_OMAP2 || ARCH_OMAP3 || ARCH_OMAP4)
> +	depends on ARCH_OMAP2PLUS
>  	help
>            Support for NAND flash on Texas Instruments OMAP2, OMAP3 and OMAP4
>  	  platforms.
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
