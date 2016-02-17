From: xhnjupt@gmail.com (Han Xu)
Date: Thu, 18 Feb 2016 01:15:02 +0800
Subject: [PATCH v4 3/7] mtd: spi-nor: fsl-quadspi: add support for
 layerscape
In-Reply-To: <1453793041-35868-3-git-send-email-yao.yuan@freescale.com>
References: <1453793041-35868-1-git-send-email-yao.yuan@freescale.com>
 <1453793041-35868-3-git-send-email-yao.yuan@freescale.com>
Message-ID: <20160217171502.GD16812@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 03:23:57PM +0800, Yuan Yao wrote:
> LS1043a and LS2080A in the Layerscape family also support Freescale Quad
> SPI, make Quad SPI selectable for these hardwares.
> 
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> ---
> Changed in v4:
> No changes.
> 
> Changed in v3:
> No changes.
> 
> Changed in v2:
> Update my email to <yao.yuan@nxp.com>
> ---
>  drivers/mtd/spi-nor/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
> index a28c278..6b53deb 100644
> --- a/drivers/mtd/spi-nor/Kconfig
> +++ b/drivers/mtd/spi-nor/Kconfig
> @@ -30,7 +30,7 @@ config MTD_SPI_NOR_USE_4K_SECTORS
>  
>  config SPI_FSL_QUADSPI
>  	tristate "Freescale Quad SPI controller"
> -	depends on ARCH_MXC || SOC_LS1021A || COMPILE_TEST
> +	depends on ARCH_MXC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	help
>  	  This enables support for the Quad SPI controller in master mode.
> -- 
> 2.1.0.27.g96db324
> 
> 
Acked-by: Han xu <han.xu@nxp.com>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
