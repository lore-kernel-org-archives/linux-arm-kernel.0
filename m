From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Mon, 9 Aug 2010 14:34:08 +0200
Subject: [PATCH 2/2] mxc_nand: remove unused variables
In-Reply-To: <d4b734ef5662b65466fbe959bd1fc993a7f08398.1281353601.git.baruch@tkos.co.il>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
	<cover.1281353601.git.baruch@tkos.co.il>
	<d4b734ef5662b65466fbe959bd1fc993a7f08398.1281353601.git.baruch@tkos.co.il>
Message-ID: <19551.62912.570721.778442@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Baruch Siach writes:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/mtd/nand/mxc_nand.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 3092240..dfa8311 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -1210,15 +1210,12 @@ static int mxcnd_suspend(struct platform_device *pdev, pm_message_t state)
>  static int mxcnd_resume(struct platform_device *pdev)
>  {
>  	struct mtd_info *mtd = platform_get_drvdata(pdev);
> -	struct nand_chip *nand_chip = mtd->priv;
> -	struct mxc_nand_host *host = nand_chip->priv;
> -	int ret = 0;
>  
>  	DEBUG(MTD_DEBUG_LEVEL0, "MXC_ND : NAND resume\n");
>  
>  	mtd->resume(mtd);
>  
There was a patch to remove the whole function mxcnd_resume() because
the call to mtd->resume() is done elsewhere in the MTD layer:
http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/018243.html


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
