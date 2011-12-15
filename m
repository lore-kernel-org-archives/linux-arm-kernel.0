From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 15 Dec 2011 14:35:36 +0100
Subject: [PATCH] AT91: Update struct atmel_nand_data to support PMECC
In-Reply-To: <1323319461-19983-1-git-send-email-hong.xu@atmel.com>
References: <1323319461-19983-1-git-send-email-hong.xu@atmel.com>
Message-ID: <4EE9F7A8.4060209@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2011 05:44 AM, Hong Xu :
> User will use the newly added field `correction_cap' and
> `sector_size' to pass PMECC parameters to driver.
> 
> Signed-off-by: Hong Xu <hong.xu@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I will queue it for 3.3 soon.

Thanks,

> ---
>  arch/arm/mach-at91/include/mach/board.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
> index eac92e9..b0035de 100644
> --- a/arch/arm/mach-at91/include/mach/board.h
> +++ b/arch/arm/mach-at91/include/mach/board.h
> @@ -117,6 +117,8 @@ struct atmel_nand_data {
>  	u8		ale;		/* address line number connected to ALE */
>  	u8		cle;		/* address line number connected to CLE */
>  	u8		bus_width_16;	/* buswidth is 16 bit */
> +	u8		correction_cap; /* PMECC correction capability */
> +	u16		sector_size;    /* Sector size for PMECC */
>  	struct mtd_partition *parts;
>  	unsigned int	num_parts;
>  };


-- 
Nicolas Ferre
