From: stefan@agner.ch (Stefan Agner)
Date: Mon, 07 Dec 2015 14:42:25 -0800
Subject: [PATCH 09/23] mtd: nand: vf610: remove useless mtd->ecclayout
 assignment
In-Reply-To: <1449527178-5930-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449527178-5930-10-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <97ccabe846d9410df0a28a2805b94a2e@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-12-07 14:26, Boris Brezillon wrote:
> The NAND core layer is already taking care of ecclayout propagation. Remove
> this useless assignment.

Thx! I see, nand_scan_tail takes care of that...

Acked-by: Stefan Agner <stefan@agner.ch>

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/vf610_nfc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> index 1c86c6b..0413e24 100644
> --- a/drivers/mtd/nand/vf610_nfc.c
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -794,8 +794,6 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  			goto error;
>  		}
>  
> -		/* propagate ecc.layout to mtd_info */
> -		mtd->ecclayout = chip->ecc.layout;
>  		chip->ecc.read_page = vf610_nfc_read_page;
>  		chip->ecc.write_page = vf610_nfc_write_page;
