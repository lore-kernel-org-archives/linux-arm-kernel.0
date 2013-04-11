From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 11 Apr 2013 09:18:32 +0900
Subject: [PATCH 15/30] mtd: onenand/samsung: make regs-onenand.h file local
In-Reply-To: <1365638712-1028578-16-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-16-git-send-email-arnd@arndb.de>
Message-ID: <CAH9JG2UK2KuX6c7YL8Mva+T+HmAH8F39oUbrK9eZkMO1KzPKFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Arnd.

On Thu, Apr 11, 2013 at 9:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Nothing uses the NAND register definitions other than the
> actual driver, so we can move the header file into the
> same local directory, which lets us build it in a multiplatform
> configuration.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mtd at lists.infradead.org
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> ---
>  drivers/mtd/onenand/samsung.c                                         | 4 ++--
>  .../include/plat/regs-onenand.h => drivers/mtd/onenand/samsung.h      | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
>  rename arch/arm/plat-samsung/include/plat/regs-onenand.h => drivers/mtd/onenand/samsung.h (98%)
>
> diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
> index 33f2a8f..2cf7408 100644
> --- a/drivers/mtd/onenand/samsung.c
> +++ b/drivers/mtd/onenand/samsung.c
> @@ -23,11 +23,11 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>
>  #include <asm/mach/flash.h>
> -#include <plat/regs-onenand.h>
>
> -#include <linux/io.h>
> +#include "samsung.h"
>
>  enum soc_type {
>         TYPE_S3C6400,
> diff --git a/arch/arm/plat-samsung/include/plat/regs-onenand.h b/drivers/mtd/onenand/samsung.h
> similarity index 98%
> rename from arch/arm/plat-samsung/include/plat/regs-onenand.h
> rename to drivers/mtd/onenand/samsung.h
> index 930ea8b..c4a80e6 100644
> --- a/arch/arm/plat-samsung/include/plat/regs-onenand.h
> +++ b/drivers/mtd/onenand/samsung.h
> @@ -11,8 +11,6 @@
>  #ifndef __SAMSUNG_ONENAND_H__
>  #define __SAMSUNG_ONENAND_H__
>
> -#include <mach/hardware.h>
> -
>  /*
>   * OneNAND Controller
>   */
> --
> 1.8.1.2
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
