From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 5 Oct 2010 13:06:25 +0900
Subject: [PATCH 1/4] ARM: SAMSUNG: Move the start address of Samsung SoCs'
	VA space
In-Reply-To: <1286244398-9333-2-git-send-email-kgene.kim@samsung.com>
References: <1286244398-9333-1-git-send-email-kgene.kim@samsung.com>
	<1286244398-9333-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTikfjiKunxZdWwbUi3cbj-20U=Fb1sO8j+Hcr8iy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 5, 2010 at 11:06 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch moves the start address of Samsung SoCs' VA space so that
> can use more vmalloc()/ioremap() space. Of course need to change the
> VMALLOC_END for it.
> Actually Samsung SoCs' VA space (free for platform use area) becomes
> 80MiB with this patch, it's enough.
>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
> ?arch/arm/plat-samsung/include/plat/map-base.h | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-samsung/include/plat/map-base.h b/arch/arm/plat-samsung/include/plat/map-base.h
> index 250be31..86f66be 100644
> --- a/arch/arm/plat-samsung/include/plat/map-base.h
> +++ b/arch/arm/plat-samsung/include/plat/map-base.h
> @@ -14,7 +14,7 @@
> ?#ifndef __ASM_PLAT_MAP_H
> ?#define __ASM_PLAT_MAP_H __FILE__
>
> -/* Fit all our registers in at 0xF4000000 upwards, trying to use as
> +/* Fit all our registers in at 0xFA000000 upwards, trying to use as
> ?* little of the VA space as possible so vmalloc and friends have a
> ?* better chance of getting memory.
> ?*
> @@ -22,7 +22,7 @@
> ?* an single MOVS instruction (ie, only 8 bits of set data)
> ?*/
>
> -#define S3C_ADDR_BASE ?(0xF4000000)
> +#define S3C_ADDR_BASE ?(0xFA000000)

maybe you could drop the brackets from the address value
