From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 27 Jul 2012 11:02:38 +0200
Subject: [PATCH] ARM: mxc: Include missing irqs.h header
In-Reply-To: <1343029278-11654-1-git-send-email-festevam@gmail.com>
References: <1343029278-11654-1-git-send-email-festevam@gmail.com>
Message-ID: <5012592E.9030205@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.07.2012 09:41, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Include irqs.h in order to fix the following build error:
> 
> arch/arm/plat-mxc/tzic.c:195:11: error: 'FIQ_START' undeclared (first use in this function)
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Dirk Behme <dirk.behme@de.bosch.com>

Could we make sure that this patch goes into mainline asap?

Recent mainline imx_v6_v7_defconfig doesn't build without this patch.

Many thanks and best regards

Dirk

P.S.: It seems that Shawn is on holiday. Could anybody help?

> ---
>  arch/arm/plat-mxc/tzic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
> index c219317..3ed1adb 100644
> --- a/arch/arm/plat-mxc/tzic.c
> +++ b/arch/arm/plat-mxc/tzic.c
> @@ -23,6 +23,7 @@
>  
>  #include <mach/hardware.h>
>  #include <mach/common.h>
> +#include <mach/irqs.h>
>  
>  #include "irq-common.h"
>  
