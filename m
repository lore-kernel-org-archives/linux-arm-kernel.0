From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 9 Jul 2014 10:25:55 -0700
Subject: [PATCH v3 2/9] mtd: nand: add ONFI timing mode to nand_timings
 converter
In-Reply-To: <1394647664-8258-3-git-send-email-b.brezillon.dev@gmail.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
 <1394647664-8258-3-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140709172555.GI7537@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Since I think you were planning on revisiting this soon, I have one more
comment:

On Wed, Mar 12, 2014 at 07:07:37PM +0100, Boris BREZILLON wrote:
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index c970ce7..0b8a822 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -2,7 +2,7 @@
>  # linux/drivers/nand/Makefile
>  #
>  
> -obj-$(CONFIG_MTD_NAND)			+= nand.o
> +obj-$(CONFIG_MTD_NAND)			+= nand.o nand_timings.o

This is not the right place, as it will generate a new module
'nand_timings' (nand_timings.ko, if CONFIG_MTD_NAND=m). You probably
want to just add nand_timings.o to the 'nand-objs' list at the bottom of
the Makefile, like this:

	nand-objs := nand_base.o nand_bbt.o nand_timings.o

>  obj-$(CONFIG_MTD_NAND_ECC)		+= nand_ecc.o
>  obj-$(CONFIG_MTD_NAND_BCH)		+= nand_bch.o
>  obj-$(CONFIG_MTD_NAND_IDS)		+= nand_ids.o nand_hynix.o

Thanks,
Brian
