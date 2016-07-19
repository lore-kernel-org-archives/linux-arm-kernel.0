From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 19 Jul 2016 17:05:10 -0500
Subject: [PATCH 9/9] [RFC] pci: include <asm/dma.h> for
 isa_dma_bridge_buggy
In-Reply-To: <1466175913-19067-10-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466175913-19067-10-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160719220510.GD18635@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 04:05:13PM +0100, Ben Dooks wrote:
> At least on arm, <asm/dma.h> does not get included when building
> drivers/pci/pci.o. This causes the following build warning which
> can be fixed by including <asm/dma.h>:
> 
> drivers/pci/pci.c:37:5: warning: symbol 'isa_dma_bridge_buggy' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied to pci/misc for v4.8, thanks, Ben!

> ---
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9add285..86b538d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -26,6 +26,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pci_hotplug.h>
>  #include <asm/setup.h>
> +#include <asm/dma.h>
>  #include <linux/aer.h>
>  #include "pci.h"
>  
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
