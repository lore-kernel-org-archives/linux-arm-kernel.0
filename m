From: ffainelli@freebox.fr (Florian Fainelli)
Date: Fri, 17 Feb 2012 09:47:35 +0100
Subject: [PATCH] mtd :  change the location of the ONFI detected log
In-Reply-To: <1329448957-9756-1-git-send-email-b32955@freescale.com>
References: <1329448957-9756-1-git-send-email-b32955@freescale.com>
Message-ID: <4F3E1427.4080502@freebox.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/17/12 04:22, Huang Shijie a ?crit :
> Some strange nand chip(such as Hynix H27UBG8T2A) can pass the `ONFI` signature
> check. So the log can be printed out even it is not an ONFI nand indeed.
>
> Change this log to the end of the function. Print out the log only when we
> really detect an ONFI nand.
>
> Signed-off-by: Huang Shijie<b32955@freescale.com>

Acked-by: Florian Fainelli <ffainelli@freebox.fr>

> ---
>   drivers/mtd/nand/nand_base.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index 5822e3a..1e907dc 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -2853,7 +2853,6 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
>   		chip->read_byte(mtd) != 'F' || chip->read_byte(mtd) != 'I')
>   		return 0;
>
> -	pr_info("ONFI flash detected\n");
>   	chip->cmdfunc(mtd, NAND_CMD_PARAM, 0, -1);
>   	for (i = 0; i<  3; i++) {
>   		chip->read_buf(mtd, (uint8_t *)p, sizeof(*p));
> @@ -2903,6 +2902,7 @@ static int nand_flash_detect_onfi(struct mtd_info *mtd, struct nand_chip *chip,
>   	chip->options |= (NAND_NO_READRDY |
>   			NAND_NO_AUTOINCR)&  NAND_CHIPOPTIONS_MSK;
>
> +	pr_info("ONFI flash detected\n");
>   	return 1;
>   }
>
