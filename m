From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 30 May 2018 10:20:00 -0500
Subject: [PATCH] PCI: versatile: include pci.h
In-Reply-To: <20180528154850.2647019-1-arnd@arndb.de>
References: <20180528154850.2647019-1-arnd@arndb.de>
Message-ID: <20180530152000.GB39853@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 05:48:39PM +0200, Arnd Bergmann wrote:
> Two patches for PCI host drivers clashed recently, leading to a broken
> build for versatile-pci:
> 
> drivers/pci/host/pci-versatile.c: In function 'versatile_pci_parse_request_of_pci_ranges':
> drivers/pci/host/pci-versatile.c:70:8: error: implicit declaration of function 'devm_of_pci_get_host_bridge_resources'; did you mean 'pci_get_host_bridge_device'? [-Werror=implicit-function-declaration]
> 
> This adds the missing header inclusion that became necessary now.
> 
> Fixes: 9e2aee80c78d ("PCI: Move private DT related functions into private header")
> Fixes: 64720fd1f630 ("PCI: Rework of_pci_get_host_bridge_resources() to devm_of_pci_get_host_bridge_resources()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, I added this in the merge where these two commits came together,
so hopefully there should be no bisection hole.

> ---
>  drivers/pci/host/pci-versatile.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
> index ff2cd12b3978..994f32061b32 100644
> --- a/drivers/pci/host/pci-versatile.c
> +++ b/drivers/pci/host/pci-versatile.c
> @@ -15,6 +15,8 @@
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  
> +#include "../pci.h"
> +
>  static void __iomem *versatile_pci_base;
>  static void __iomem *versatile_cfg_base[2];
>  
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
