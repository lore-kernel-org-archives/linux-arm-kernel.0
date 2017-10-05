From: sstabellini@kernel.org (Stefano Stabellini)
Date: Thu, 5 Oct 2017 12:58:32 -0700 (PDT)
Subject: [PATCH 1/3] arm/xen: don't inclide rwlock.h directly.1~B
In-Reply-To: <20171005125655.12373-1-bigeasy@linutronix.de>
References: <20171005125655.12373-1-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.10.1710051256230.3073@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Oct 2017, Sebastian Andrzej Siewior wrote:
> rwlock.h should not be included directly. Instead linux/splinlock.h
> should be included. One thing it does is to break the RT build.
> 
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel at lists.xenproject.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

Let me know if you want this patch to go via the xen tree.

> ---
>  arch/arm/xen/p2m.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
> index e71eefa2e427..0641ba54ab62 100644
> --- a/arch/arm/xen/p2m.c
> +++ b/arch/arm/xen/p2m.c
> @@ -1,7 +1,7 @@
>  #include <linux/bootmem.h>
>  #include <linux/gfp.h>
>  #include <linux/export.h>
> -#include <linux/rwlock.h>
> +#include <linux/spinlock.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/dma-mapping.h>
> -- 
> 2.14.2
> 
