From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Sep 2012 03:22:04 +0200
Subject: [PATCH 2/6] ARM: dove: Fix tauros2 device tree init
In-Reply-To: <1348531338-16624-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1348531338-16624-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5061073C.4010002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 02:02 AM, Sebastian Hesselbarth wrote:
> During the review process of dove DT patches, Tauros2 cache
> init call was changed and DT support added. This patch fixes
> the call to Tauros2 init and adds a DT node. Moreover, plat/irq.h
> include was missing from mach-dove/common.c.
 > ...
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index b37bef1..343a4bc 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -32,6 +32,7 @@
>   #include<linux/irq.h>
>   #include<plat/time.h>
>   #include<linux/platform_data/usb-ehci-orion.h>
> +#include<plat/irq.h>
>   #include<plat/common.h>
>   #include<plat/addr-map.h>
>   #include "common.h"
> @@ -399,7 +400,7 @@ static void __init dove_dt_init(void)
>   		(dove_tclk + 499999) / 1000000);
>
>   #ifdef CONFIG_CACHE_TAUROS2
> -	tauros2_init();
> +	tauros2_init(0);
>   #endif
>   	dove_setup_cpu_mbus();
>

I thought about the importance of the individual patches and
except 2/6 all can wait for the next release cycle if too late.

But 2/6 is important because the change in tauros2_init
breaks build on dove.

Sebastian
