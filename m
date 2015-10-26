From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 26 Oct 2015 11:34:07 -0700
Subject: [PATCH v4 2/5] mtd: nand: allow compile test of MTD_NAND_PXA3xx
In-Reply-To: <1445416144-9194-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
 <1445416144-9194-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20151026183407.GB13239@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 10:29:01AM +0200, Antoine Tenart wrote:
> Allow compile test of the MTD_NAND_PXA3xx nand driver.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/mtd/nand/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 289664089cf3..554aff7b2f8b 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -329,7 +329,7 @@ config MTD_NAND_ATMEL
>  
>  config MTD_NAND_PXA3xx
>  	tristate "NAND support on PXA3xx and Armada 370/XP"
> -	depends on PXA3xx || ARCH_MMP || PLAT_ORION
> +	depends on PXA3xx || ARCH_MMP || PLAT_ORION || COMPILE_TEST

You need at least a dependency on HAS_IOMEM. I'll drop this patch for
now, as it's unrelated. Feel free to send another revision.

Brian

>  	help
>  	  This enables the driver for the NAND flash device found on
>  	  PXA3xx processors (NFCv1) and also on Armada 370/XP (NFCv2).
> -- 
> 2.6.2
> 
