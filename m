From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 18 Jul 2011 15:51:48 +0800
Subject: [PATCH 1/3] ARM: pxa168: Remove MTD specific headers
In-Reply-To: <1310971931-4825-2-git-send-email-tanmay.upadhyay@einfochips.com>
References: <1310971931-4825-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<1310971931-4825-2-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <CAMPhdO_qVn8JaX6orfnHHXjmi8pTQFb1SzMe2RQM9xMdTvimaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 2:52 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
> mtd.h defines 'DEBUG' which unintentionally changes behavior

I guess the right solution is to fix mtd.h instead of pxa3xx_nand.h

> of other files that includes pxa3xx_nand.h OR pxa168.h. Anyway,
> neither mtd/mtd.h nor mtd/partitions.h is needed here

There is a reference of 'struct mtd_partition' below. Though it's possible
to remove mtd header references, and declare 'struct mtd_partition' as
opaque, the mtd header files are still needed when defining partition
layout in board file.

>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> ---
> ?arch/arm/plat-pxa/include/plat/pxa3xx_nand.h | ? ?3 ---
> ?1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
> index 442301f..641c781 100644
> --- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
> +++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
> @@ -1,9 +1,6 @@
> ?#ifndef __ASM_ARCH_PXA3XX_NAND_H
> ?#define __ASM_ARCH_PXA3XX_NAND_H
>
> -#include <linux/mtd/mtd.h>
> -#include <linux/mtd/partitions.h>
> -
> ?struct pxa3xx_nand_timing {
> ? ? ? ?unsigned int ? ?tCH; ?/* Enable signal hold time */
> ? ? ? ?unsigned int ? ?tCS; ?/* Enable signal setup time */
> --
> 1.7.0.4
>
>
