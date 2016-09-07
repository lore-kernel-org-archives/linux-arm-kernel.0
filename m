From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 7 Sep 2016 21:29:30 +0200
Subject: [PATCH 7/7] mtd: nand: remove unnecessary 'extern' from
 function declarations
In-Reply-To: <1473250902-31139-8-git-send-email-s.hauer@pengutronix.de>
References: <1473250902-31139-1-git-send-email-s.hauer@pengutronix.de>
 <1473250902-31139-8-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160907212930.66310fa5@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  7 Sep 2016 14:21:42 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> 'extern' is not necessary for function declarations. To prevent
> people from adding the keyword to new declarations remove the
> existing ones.
> 

Applied.

Thanks,

Boris

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  include/linux/mtd/nand.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index 9f3d7be..7989178 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -29,26 +29,26 @@ struct nand_flash_dev;
>  struct device_node;
>  
>  /* Scan and identify a NAND device */
> -extern int nand_scan(struct mtd_info *mtd, int max_chips);
> +int nand_scan(struct mtd_info *mtd, int max_chips);
>  /*
>   * Separate phases of nand_scan(), allowing board driver to intervene
>   * and override command or ECC setup according to flash type.
>   */
> -extern int nand_scan_ident(struct mtd_info *mtd, int max_chips,
> +int nand_scan_ident(struct mtd_info *mtd, int max_chips,
>  			   struct nand_flash_dev *table);
> -extern int nand_scan_tail(struct mtd_info *mtd);
> +int nand_scan_tail(struct mtd_info *mtd);
>  
>  /* Free resources held by the NAND device */
> -extern void nand_release(struct mtd_info *mtd);
> +void nand_release(struct mtd_info *mtd);
>  
>  /* Internal helper for board drivers which need to override command function */
> -extern void nand_wait_ready(struct mtd_info *mtd);
> +void nand_wait_ready(struct mtd_info *mtd);
>  
>  /* locks all blocks present in the device */
> -extern int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
> +int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
>  
>  /* unlocks specified locked blocks */
> -extern int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
> +int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
>  
>  /* The maximum number of NAND chips in an array */
>  #define NAND_MAX_CHIPS		8
> @@ -1013,14 +1013,14 @@ struct nand_manufacturers {
>  extern struct nand_flash_dev nand_flash_ids[];
>  extern struct nand_manufacturers nand_manuf_ids[];
>  
> -extern int nand_default_bbt(struct mtd_info *mtd);
> -extern int nand_markbad_bbt(struct mtd_info *mtd, loff_t offs);
> -extern int nand_isreserved_bbt(struct mtd_info *mtd, loff_t offs);
> -extern int nand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt);
> -extern int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
> -			   int allowbbt);
> -extern int nand_do_read(struct mtd_info *mtd, loff_t from, size_t len,
> -			size_t *retlen, uint8_t *buf);
> +int nand_default_bbt(struct mtd_info *mtd);
> +int nand_markbad_bbt(struct mtd_info *mtd, loff_t offs);
> +int nand_isreserved_bbt(struct mtd_info *mtd, loff_t offs);
> +int nand_isbad_bbt(struct mtd_info *mtd, loff_t offs, int allowbbt);
> +int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
> +		    int allowbbt);
> +int nand_do_read(struct mtd_info *mtd, loff_t from, size_t len,
> +		 size_t *retlen, uint8_t *buf);
>  
>  /**
>   * struct platform_nand_chip - chip level device structure
