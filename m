From: alison.wang@nxp.com (Alison Wang)
Date: Thu, 5 Jan 2017 02:02:30 +0000
Subject: [PATCH v2 2/2] mtd: nand: Update dependency of IFC for LS1021A
In-Reply-To: <ffb2c20d-3aeb-6f5a-1880-3bed0c964821@gmail.com>
References: <1483411266-45875-1-git-send-email-b18965@freescale.com>
 <1483411266-45875-2-git-send-email-b18965@freescale.com>
 <4e04eb5e-fb53-f71e-ee49-0872a6c11e97@gmail.com>
 <DB6PR0401MB2584606EC932BF1FAED788E1F4610@DB6PR0401MB2584.eurprd04.prod.outlook.com>
 <ffb2c20d-3aeb-6f5a-1880-3bed0c964821@gmail.com>
Message-ID: <DB6PR0401MB2584DBE5D6496F44B7169B49F4600@DB6PR0401MB2584.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 01/04/2017 02:46 AM, Alison Wang wrote:
> >> On 01/03/2017 03:41 AM, Alison Wang wrote:
> >>> As NAND support for Freescale/NXP IFC controller is available on
> >>> LS1021A, the dependency for LS1021A is added.
> >>
> >> Does LS stand for LayerScape ? Yes it does. So why does
> >> ARCH_LAYERSCAPE not cover LS1021 ?
> > [Alison Wang] LS1021A is an earlier product and is not compatible
> with later Layerscape architecture. So ARCH_LAYERSCAPE can't cover
> LS1021A.
> 
> Ah ok, I see. That information would be useful in the commit message ;-)
> 
[Alison Wang] Ok. :)
> >>
> >>> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> >>> ---
> >>> Changes in v2:
> >>> - None
> >>>
> >>>  drivers/mtd/nand/Kconfig | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> >> index
> >>> 353a9dd..85e3860 100644
> >>> --- a/drivers/mtd/nand/Kconfig
> >>> +++ b/drivers/mtd/nand/Kconfig
> >>> @@ -441,7 +441,7 @@ config MTD_NAND_FSL_ELBC
> >>>
> >>>  config MTD_NAND_FSL_IFC
> >>>  	tristate "NAND support for Freescale IFC controller"
> >>> -	depends on FSL_SOC || ARCH_LAYERSCAPE
> >>> +	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A
> >>>  	select FSL_IFC
> >>>  	select MEMORY
> >>>  	help
> >>>
> >
> > Best Regards,
> > Alison Wang
> >
> 
> 
> --
> Best regards,
> Marek Vasut

Best Regards,
Alison Wang
