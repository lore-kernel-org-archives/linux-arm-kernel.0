From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 Dec 2015 10:43:58 +0000
Subject: [PATCH] IRQ/Platform-MSI:Increase the maximum MSIs the MSI
 framework can support.
In-Reply-To: <1450667905-2968-1-git-send-email-majun258@huawei.com>
References: <1450667905-2968-1-git-send-email-majun258@huawei.com>
Message-ID: <20151221104358.18734bc3@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Dec 2015 11:18:25 +0800
MaJun <majun258@huawei.com> wrote:

> From: Ma Jun <majun258@huawei.com>
> 
> The current MSI framework can only support 256 platform MSIs.
> 
> But on Hisilicon platform, some network related devices has about 500
> wired interrupts.
> 
> To support these devices, we need a new maximum value more than 256.
> 
> Signed-off-by: Ma Jun <majun258@huawei.com>
> ---
>  drivers/base/platform-msi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index a203896..9c00d3f 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -24,7 +24,7 @@
>  #include <linux/msi.h>
>  #include <linux/slab.h>
>  
> -#define DEV_ID_SHIFT	24
> +#define DEV_ID_SHIFT	22
>  #define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
>  
>  /*

If we bother doing that, why not directly aligning it with MSI-X and
allow up to 2048 interrupts per device? It is only an extra bit, and
that still leaves 21 bits worth of device IDs, while still having
hwirq as an unsigned long (32bit on 32bit architectures).

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
