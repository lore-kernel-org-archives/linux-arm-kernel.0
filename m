From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 31 Dec 2011 13:44:33 +0800
Subject: [PATCH] MTD/GPMI : select more modules for GPMI by default
In-Reply-To: <1325220337-23165-1-git-send-email-b32955@freescale.com>
References: <1325220337-23165-1-git-send-email-b32955@freescale.com>
Message-ID: <20111231054432.GE12182@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2011 at 12:45:37PM +0800, Huang Shijie wrote:
> The gpmi-nand driver needs the mxs-dma driver. So select the
> MXS_DMA by default. So does the MTD_CHAR.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  drivers/mtd/nand/Kconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 07c4774..1b14a3a 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -420,6 +420,8 @@ config MTD_NAND_NANDSIM
>  config MTD_NAND_GPMI_NAND
>          bool "GPMI NAND Flash Controller driver"
>          depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28)
> +	select MXS_DMA

We should probably have it depend on MXS_DMA rather than select it.

Regards,
Shawn

> +	select MTD_CHAR
>  	select MTD_PARTITIONS
>  	select MTD_CMDLINE_PARTS
>          help
> -- 
> 1.7.0.4
