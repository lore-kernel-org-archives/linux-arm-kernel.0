From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 15 Apr 2015 23:38:10 +0200
Subject: [PATCH v4 05/10] mtd: nand: add Samsung K9GBG08U0A-M to nand_ids
 table
In-Reply-To: <1429118648-19416-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1429118648-19416-1-git-send-email-antoine.tenart@free-electrons.com>
 <1429118648-19416-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <552EDA42.7070700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.04.2015 19:24, Antoine Tenart wrote:
> Add the full description of the Samsung K9GBG08U0A-M nand chip in the
> nand_ids table.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>   drivers/mtd/nand/nand_ids.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mtd/nand/nand_ids.c b/drivers/mtd/nand/nand_ids.c
> index dd620c19c619..500c33e1db06 100644
> --- a/drivers/mtd/nand/nand_ids.c
> +++ b/drivers/mtd/nand/nand_ids.c
> @@ -50,6 +50,10 @@ struct nand_flash_dev nand_flash_ids[] = {
>   		{ .id = {0xad, 0xde, 0x94, 0xda, 0x74, 0xc4} },
>   		  SZ_8K, SZ_8K, SZ_2M, 0, 6, 640, NAND_ECC_INFO(40, SZ_1K),
>   		  4 },
> +	{"NAND 4GiB 3,3V 8-bit",
> +		{ .id = {0xec, 0xd7, 0x94, 0x76, 0x64, 0x43}, },
> +		  8192, 4096, SZ_1M, LP_OPTIONS, 0, 0, NAND_ECC_INFO(40, SZ_1K),
> +		  4 },

According to the datasheet p.50, ECC_INFO() could also be parsed from
byte 5 bits [6:4] of EXT_ID.

I tried to catch up with the onfi_timing_mode_default discussion but
failed. Can someone please put me in the picture if we are going to add
full_id chips just because of the equivalent onfi timing mode? Or is it
safe to assume that all 0xd7 chips are mode 4 compatible?

Sebastian

>
>   	LEGACY_ID_NAND("NAND 4MiB 5V 8-bit",   0x6B, 4, SZ_8K, SP_OPTIONS),
>   	LEGACY_ID_NAND("NAND 4MiB 3,3V 8-bit", 0xE3, 4, SZ_8K, SP_OPTIONS),
>
