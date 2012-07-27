From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Jul 2012 17:30:00 +0800
Subject: [PATCH v2 1/3] mtd: nand: Include IMX6 in the list of supported
 SoCs
In-Reply-To: <1343215100-24005-1-git-send-email-festevam@gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
Message-ID: <20120727092959.GF3347@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 08:18:18AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Include IMX6 in the list of supported SoCs.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - No changes
>  drivers/mtd/nand/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index f4e81a7..b40e172 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -464,7 +464,7 @@ config MTD_NAND_GPMI_NAND
>          bool "GPMI NAND Flash Controller driver"
>          depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q)
We don't need to list all SoCs. Shall we just check MXC or MXS ?

Thanks
Richard
>          help
> -	 Enables NAND Flash support for IMX23 or IMX28.
> +	 Enables NAND Flash support for IMX23, IMX28 or IMX6.
>  	 The GPMI controller is very powerful, with the help of BCH
>  	 module, it can do the hardware ECC. The GPMI supports several
>  	 NAND flashs at the same time. The GPMI may conflicts with other
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
