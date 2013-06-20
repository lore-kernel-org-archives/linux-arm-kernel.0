From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 20 Jun 2013 05:59:02 +0000
Subject: [PATCH] ARM: OMAP2: reboot: Include common.h to fix build error
In-Reply-To: <1371664001.9848.1.camel@phoenix>
References: <1371664001.9848.1.camel@phoenix>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB22C4C@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 19, 2013 at 23:16:41, Axel Lin wrote:

> Include common.h which will include linux/reboot.h to fix below build error.
> 
>   CC      arch/arm/mach-omap2/omap4-restart.o
> arch/arm/mach-omap2/omap4-restart.c:21:28: warning: 'enum reboot_mode' declared inside parameter list [enabled by default]
> arch/arm/mach-omap2/omap4-restart.c:21:28: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> arch/arm/mach-omap2/omap4-restart.c:21:40: error: parameter 1 ('mode') has incomplete type
> arch/arm/mach-omap2/omap4-restart.c:21:6: warning: function declaration isn't a prototype [-Wstrict-prototypes]
> make[1]: *** [arch/arm/mach-omap2/omap4-restart.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Seems this build error is introduced by commit 7507d035f3cf40c
> "reboot: arm: change reboot_mode to use enum reboot_mode"
> 
> This patch is against linux-next 20130619.

> diff --git a/arch/arm/mach-omap2/omap4-restart.c b/arch/arm/mach-omap2/omap4-restart.c
> index 652adde..7306d9b 100644
> --- a/arch/arm/mach-omap2/omap4-restart.c
> +++ b/arch/arm/mach-omap2/omap4-restart.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/types.h>
>  #include "prminst44xx.h"
> +#include "common.h"

Arnd has posted a patch [1] that includes reboot.h directly for
multiple platforms including this one.

Regards
Afzal

[1] https://lkml.org/lkml/2013/6/19/498
