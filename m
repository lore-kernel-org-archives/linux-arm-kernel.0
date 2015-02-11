From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 11 Feb 2015 09:42:56 +0100
Subject: [PATCH 6/6] [RFC] mtd: mxc-nand: Warn on unimplemented commands
In-Reply-To: <1423594800-24214-7-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1423594800-24214-7-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150211094256.2ef2805b@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Uwe Kleine-K?nig wrote:
> The PARAM command was long unimplemented and it probably wasn't
> noticed because chip probing using only the few bytes returned by the
> READID command are good enough in most cases to determine the chip in
> use.
> 
> Still to notice such a shortcoming earlier in the future would be nice
> in case it's something more vital.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mtd/nand/mxc_nand.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
> index 0083b4ee4f33..372e0e38f59b 100644
> --- a/drivers/mtd/nand/mxc_nand.c
> +++ b/drivers/mtd/nand/mxc_nand.c
> @@ -1160,6 +1160,10 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
>  		memcpy32_fromio(host->data_buf, host->main_area0, 512);
>  		host->buf_start = 0;
>  		break;
> +	default:
> +		WARN_ONCE(1, "Unimplemented command (cmd=%u)\n",
> +			  command);
> +		break;
>  	}
useless break;


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
