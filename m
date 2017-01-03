From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 3 Jan 2017 12:46:14 +0100
Subject: [PATCH v2 2/2] mtd: nand: Update dependency of IFC for LS1021A
In-Reply-To: <1483411266-45875-2-git-send-email-b18965@freescale.com>
References: <1483411266-45875-1-git-send-email-b18965@freescale.com>
 <1483411266-45875-2-git-send-email-b18965@freescale.com>
Message-ID: <4e04eb5e-fb53-f71e-ee49-0872a6c11e97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2017 03:41 AM, Alison Wang wrote:
> As NAND support for Freescale/NXP IFC controller is available on
> LS1021A, the dependency for LS1021A is added.

Does LS stand for LayerScape ? Yes it does. So why does ARCH_LAYERSCAPE
not cover LS1021 ?

> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> ---
> Changes in v2:
> - None
> 
>  drivers/mtd/nand/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 353a9dd..85e3860 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -441,7 +441,7 @@ config MTD_NAND_FSL_ELBC
>  
>  config MTD_NAND_FSL_IFC
>  	tristate "NAND support for Freescale IFC controller"
> -	depends on FSL_SOC || ARCH_LAYERSCAPE
> +	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A
>  	select FSL_IFC
>  	select MEMORY
>  	help
> 


-- 
Best regards,
Marek Vasut
