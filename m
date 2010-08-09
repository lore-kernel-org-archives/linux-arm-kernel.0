From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 9 Aug 2010 14:28:33 +0200
Subject: [PATCH 1/2] mxc_nand: fix build error
In-Reply-To: <4db426cd74bc8aae80ddcbf666681c3cd439dfc7.1281353601.git.baruch@tkos.co.il>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
	<cover.1281353601.git.baruch@tkos.co.il>
	<4db426cd74bc8aae80ddcbf666681c3cd439dfc7.1281353601.git.baruch@tkos.co.il>
Message-ID: <20100809122833.GB27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 09, 2010 at 02:38:13PM +0300, Baruch Siach wrote:
> drivers/mtd/nand/mxc_nand.c: In function 'mxc_nand_command':
> drivers/mtd/nand/mxc_nand.c:908: error: implicit declaration of function 'send_cmd'

This is because you based my series on 2.6.35. With current master this
patch is not necessary.

Sascha

> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/mtd/nand/mxc_nand.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 4032e0b..3092240 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -905,13 +905,13 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
>  
>  			/* Set program pointer to spare region */
>  			if (mtd->writesize == 512)
> -				send_cmd(host, NAND_CMD_READOOB, false);
> +				host->send_cmd(host, NAND_CMD_READOOB, false);
>  		} else {
>  			host->buf_start = column;
>  
>  			/* Set program pointer to page start */
>  			if (mtd->writesize == 512)
> -				send_cmd(host, NAND_CMD_READ0, false);
> +				host->send_cmd(host, NAND_CMD_READ0, false);
>  		}
>  
>  		host->send_cmd(host, command, false);
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
