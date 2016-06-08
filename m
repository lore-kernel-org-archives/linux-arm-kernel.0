From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 8 Jun 2016 13:13:56 +0100
Subject: [PATCH] arm64: mm: only initialize swiotlb when necessary
In-Reply-To: <1465372426-4077-1-git-send-email-jszhang@marvell.com>
References: <1465372426-4077-1-git-send-email-jszhang@marvell.com>
Message-ID: <20160608121356.GC16322@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 03:53:46PM +0800, Jisheng Zhang wrote:
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -19,6 +19,7 @@
>  
>  #include <linux/gfp.h>
>  #include <linux/acpi.h>
> +#include <linux/bootmem.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/genalloc.h>

Why is this include needed?

-- 
Catalin
