From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 18 Jul 2018 10:03:09 +0200
Subject: [PATCH] mtd: nuc900_nand: mark expected switch fall-through
In-Reply-To: <20180710132902.GA13541@embeddedor.com>
References: <20180710132902.GA13541@embeddedor.com>
Message-ID: <20180718100309.49c5452a@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gustavo,

Prefix should be "mtd: rawnand: nuc900:"

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Tue, 10 Jul
2018 08:29:02 -0500:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 1471717 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mtd/nand/raw/nuc900_nand.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nuc900_nand.c b/drivers/mtd/nand/raw/nuc900_nand.c
> index af5b32c9..53a9f6c 100644
> --- a/drivers/mtd/nand/raw/nuc900_nand.c
> +++ b/drivers/mtd/nand/raw/nuc900_nand.c
> @@ -191,8 +191,9 @@ static void nuc900_nand_command_lp(struct mtd_info *mtd, unsigned int command,
>  		return;
>  
>  	case NAND_CMD_READ0:
> -
>  		write_cmd_reg(nand, NAND_CMD_READSTART);
> +		/* fall through */

Have you checked this is actually the right thing to do?

Thanks,
Miqu?l
