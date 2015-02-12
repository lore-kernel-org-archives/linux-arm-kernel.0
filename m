From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 12 Feb 2015 16:17:32 +0100
Subject: [PATCH v2 05/10] mtd: pxa3xx_nand: add a default chunk size
In-Reply-To: <1423752816-26219-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1423752816-26219-1-git-send-email-antoine.tenart@free-electrons.com>
 <1423752816-26219-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150212161732.7542331b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 Feb 2015 15:53:31 +0100
Antoine Tenart <antoine.tenart@free-electrons.com> wrote:

> Add a default chunk size of 512 in the pxa3xx nand driver.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 64628bff3fa5..8ed045195d31 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -1430,6 +1430,9 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
>  	if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
>  		goto KEEP_CONFIG;
>  
> +	/* Set a default chunk size */

Ditto => no explanation about why you do that.

> +	info->chunk_size = 512;
> +
>  	ret = pxa3xx_nand_sensing(info);
>  	if (ret) {
>  		dev_info(&info->pdev->dev, "There is no chip on cs %d!\n",



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
