From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 13 Aug 2017 09:40:19 +0200
Subject: [PATCH v4 2/9] mtd: nand: sharpsl.h: support partition parser
 types
In-Reply-To: <1498681836-3765-3-git-send-email-andrea.adami@gmail.com>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
 <1498681836-3765-3-git-send-email-andrea.adami@gmail.com>
Message-ID: <20170813094019.2fced1d1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 28 Jun 2017 22:30:29 +0200,
Andrea Adami <andrea.adami@gmail.com> a ?crit :

Please add a commit message explaining why you're doing that.

> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> ---
>  include/linux/mtd/sharpsl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mtd/sharpsl.h b/include/linux/mtd/sharpsl.h
> index 65e91d0..c0e0be2 100644
> --- a/include/linux/mtd/sharpsl.h
> +++ b/include/linux/mtd/sharpsl.h
> @@ -17,4 +17,5 @@ struct sharpsl_nand_platform_data {
>  	const struct mtd_ooblayout_ops *ecc_layout;
>  	struct mtd_partition	*partitions;
>  	unsigned int		nr_partitions;
> +	const char *const	*types;	/* names of parsers to use if any */

types is not really descriptive here. How about 'part_parsers' or
something clearly reflecting the purpose of this field.

BTW, try to avoid putting comments on the same line.

>  };
