From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 27 Jun 2017 17:52:28 -0500
Subject: [PATCH 4/4] PCI: versatile: fix another typo
In-Reply-To: <20170621215323.3921382-4-arnd@arndb.de>
References: <20170621215323.3921382-1-arnd@arndb.de>
 <20170621215323.3921382-4-arnd@arndb.de>
Message-ID: <20170627225228.GH17844@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 11:53:02PM +0200, Arnd Bergmann wrote:
> The struct members were added to the wrong variable:
> 
> drivers/pci/host/pci-versatile.c: In function 'versatile_pci_probe':
> drivers/pci/host/pci-versatile.c:212:2: error: 'host' undeclared (first use in this function)
> 
> Fixes: 997995e1722a ("PCI: versatile: Drop pci_fixup_irqs()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Folded into Lorenzo's series on pci/enumeration, thanks!

> ---
>  drivers/pci/host/pci-versatile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
> index f572c921cdd4..f6fcec6b5578 100644
> --- a/drivers/pci/host/pci-versatile.c
> +++ b/drivers/pci/host/pci-versatile.c
> @@ -209,8 +209,8 @@ static int versatile_pci_probe(struct platform_device *pdev)
>  	bridge->sysdata = NULL;
>  	bridge->busnr = 0;
>  	bridge->ops = &pci_versatile_ops;
> -	host->map_irq = of_irq_parse_and_map_pci;
> -	host->swizzle_irq = pci_common_swizzle;
> +	bridge->map_irq = of_irq_parse_and_map_pci;
> +	bridge->swizzle_irq = pci_common_swizzle;
>  
>  	ret = pci_scan_root_bus_bridge(bridge);
>  	if (ret < 0)
> -- 
> 2.9.0
> 
