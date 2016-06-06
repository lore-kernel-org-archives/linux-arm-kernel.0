From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 6 Jun 2016 20:55:49 +0200
Subject: [PATCH 5/7] mtd: nand: Add Hynix H27UBG8T2BTR-BC to nand_ids table
In-Reply-To: <1465208664-9366-6-git-send-email-mamlinav@gmail.com>
References: <1465208664-9366-1-git-send-email-mamlinav@gmail.com>
 <1465208664-9366-6-git-send-email-mamlinav@gmail.com>
Message-ID: <20160606205549.1ecd6fdb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  6 Jun 2016 13:24:22 +0300
Aleksei Mamlin <mamlinav@gmail.com> wrote:

> Add the full description of the Hynix H27UBG8T2BTR-BC NAND chip in the
> nand_ids table so that we can later use the NAND ECC infos and ONFI timings
> mode in controller drivers.

Still hoping to get this series [1] merged in 4.8, but if that's
not the case, I'll apply your patch.

BTW, that would be great if you could test it on your platforms.

Regards,

Boris

[1]https://lkml.org/lkml/2016/5/27/264

> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  drivers/mtd/nand/nand_ids.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/nand/nand_ids.c b/drivers/mtd/nand/nand_ids.c
> index ccc05f5..ccdc773 100644
> --- a/drivers/mtd/nand/nand_ids.c
> +++ b/drivers/mtd/nand/nand_ids.c
> @@ -52,6 +52,10 @@ struct nand_flash_dev nand_flash_ids[] = {
>  		{ .id = {0xad, 0xde, 0x94, 0xda, 0x74, 0xc4} },
>  		  SZ_8K, SZ_8K, SZ_2M, NAND_NEED_SCRAMBLING, 6, 640,
>  		  NAND_ECC_INFO(40, SZ_1K), 4 },
> +	{"H27UBG8T2BTR-BC 32G 3.3V 8-bit",
> +		{ .id = {0xad, 0xd7, 0x94, 0xda, 0x74, 0xc3} },
> +		  SZ_8K, SZ_4K, SZ_2M, NAND_NEED_SCRAMBLING, 6, 640,
> +		  NAND_ECC_INFO(40, SZ_1K), 0 },
>  
>  	LEGACY_ID_NAND("NAND 4MiB 5V 8-bit",   0x6B, 4, SZ_8K, SP_OPTIONS),
>  	LEGACY_ID_NAND("NAND 4MiB 3,3V 8-bit", 0xE3, 4, SZ_8K, SP_OPTIONS),



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
