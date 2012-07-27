From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Jul 2012 17:28:20 +0800
Subject: [PATCH v2 2/3] mtd: nand: Let MTD_NAND_GPMI_NAND depend on MXS_DMA
In-Reply-To: <1343215100-24005-2-git-send-email-festevam@gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-2-git-send-email-festevam@gmail.com>
Message-ID: <20120727092819.GE3347@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 08:18:19AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> MTD_NAND_GPMI_NAND driver depends on MXS_DMA to be selected, otherwise the following error happens
> for imx_v6_v7_defconfig:
> 
> drivers/built-in.o: In function `gpmi_dma_filter':
> clk-fixed-factor.c:(.text+0xb124c): undefined reference to `mxs_dma_is_apbh'
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Reviewed-by: Richard Zhao <richard.zhao@freescale.com>
> ---
> Changes since v1:
> - Use 'depends' rather than 'select'
>  drivers/mtd/nand/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index a5d8a1b..da52c7d 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -463,6 +463,7 @@ config MTD_NAND_NANDSIM
>  config MTD_NAND_GPMI_NAND
>          bool "GPMI NAND Flash Controller driver"
>          depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q)
> +	depends on MXS_DMA
>          help
>  	 Enables NAND Flash support for IMX23, IMX28 or IMX6.
>  	 The GPMI controller is very powerful, with the help of BCH
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
