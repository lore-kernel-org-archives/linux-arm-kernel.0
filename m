From: Joao.Pinto@synopsys.com (Joao Pinto)
Date: Tue, 15 May 2018 15:28:39 +0100
Subject: [PATCH v4 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
In-Reply-To: <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
Message-ID: <73eb2628-0d45-f23b-72c2-e463aef71f3f@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Jan,

?s 10:07 AM de 5/15/2018, Jan Kiszka escreveu:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> of_pci_get_host_bridge_resources() allocates the resource structures it
> fills dynamically, but none of its callers care to release them so far.
> Rather than requiring everyone to do this explicitly, convert the
> existing function to a managed version.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/pci/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/host/pci-aardvark.c        |  2 +-
>  drivers/pci/host/pci-ftpci100.c        |  2 +-
>  drivers/pci/host/pci-v3-semi.c         |  2 +-
>  drivers/pci/host/pci-versatile.c       |  2 +-
>  drivers/pci/host/pci-xgene.c           |  2 +-
>  drivers/pci/host/pcie-altera.c         |  2 +-
>  drivers/pci/host/pcie-iproc-platform.c |  2 +-
>  drivers/pci/host/pcie-rcar.c           |  2 +-
>  drivers/pci/host/pcie-rockchip.c       |  2 +-
>  drivers/pci/host/pcie-xilinx-nwl.c     |  2 +-
>  drivers/pci/host/pcie-xilinx.c         |  2 +-
>  drivers/pci/of.c                       | 30 ++++++++++++------------------
>  include/linux/of_pci.h                 |  4 ++--
>  14 files changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 5a535690b7b5..a8f6ab54b4c0 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -342,7 +342,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	ret = of_pci_get_host_bridge_resources(dev, 0, 0xff,
> +	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>  					&bridge->windows, &pp->io_base);
>  	if (ret)
>  		return ret;

(snip...)

Thanks for this patch!

Acked-by: Joao Pinto <jpinto@synopsys.com>
