From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Jul 2012 11:30:22 +0800
Subject: [PATCH] ARM: imx: Fix build error due to missing irqs.h include
In-Reply-To: <1341365144-4549-1-git-send-email-festevam@gmail.com>
References: <1341365144-4549-1-git-send-email-festevam@gmail.com>
Message-ID: <20120704033018.GA1862@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dammit.  I forgot testing imx_v4_v5_defconfig again with the last FIQ
change.  Thanks, Fabio.

Arnd,

I just updated the branch imx/sparse-irq with this fix applied.  Can
you please pull it?

Regards,
Shawn

The following changes since commit 8842a9e2869cae14bbb8184004a42fc3070587fb:

  ARM: imx: enable SPARSE_IRQ for imx platform (2012-07-01 21:59:20 +0800)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/sparse-irq

Fabio Estevam (1):
      ARM: imx: Fix build error due to missing irqs.h include

 arch/arm/plat-mxc/avic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


On Tue, Jul 03, 2012 at 10:25:44PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> commit bc8966 (ARM: fiq: change FIQ_START to a variable) introduced the 
> following build error for imx_v4_v5_defconfig:
> 
> arch/arm/plat-mxc/avic.c:220:11: error: 'FIQ_START' undeclared (first use in this function)
> 
> Include the missing header file to fix it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/plat-mxc/avic.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
> index f3d671f..cbd55c3 100644
> --- a/arch/arm/plat-mxc/avic.c
> +++ b/arch/arm/plat-mxc/avic.c
> @@ -26,6 +26,7 @@
>  #include <asm/mach/irq.h>
>  #include <asm/exception.h>
>  #include <mach/hardware.h>
> +#include <mach/irqs.h>
>  
>  #include "irq-common.h"
>  
> -- 
> 1.7.1
> 
