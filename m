From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 20 Apr 2012 10:27:29 +0200
Subject: [PATCH v4 2/2] MTD: AT91: Update atmel_nand_data to support PMECC
In-Reply-To: <1334906788-18704-2-git-send-email-hong.xu@atmel.com>
References: <1334906788-18704-1-git-send-email-hong.xu@atmel.com>
 <1334906788-18704-2-git-send-email-hong.xu@atmel.com>
Message-ID: <20120420082729.GY16641@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:26 Fri 20 Apr     , Hong Xu wrote:
> Added two items,
> * correction_cap: PMECC correction capability
> * sector_size:    Sector size for PMECC
> 
> Signed-off-by: Hong Xu <hong.xu@atmel.com>
> ---
>  include/linux/platform_data/atmel.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> index b0f2c56..4d9bfd5 100644
> --- a/include/linux/platform_data/atmel.h
> +++ b/include/linux/platform_data/atmel.h
> @@ -20,6 +20,8 @@ struct atmel_nand_data {
>  	u8		bus_width_16;		/* buswidth is 16 bit */
>  	u8		ecc_mode;		/* ecc mode */
>  	u8		on_flash_bbt;		/* bbt on flash */
> +	u8		correction_cap;		/* PMECC capability */
> +	u16		sector_size;		/* Sector size for PMECC */
as this only used by DT
no need to expose it

Best Regards,
J.
