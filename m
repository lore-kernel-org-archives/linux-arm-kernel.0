From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 23 Sep 2014 16:53:56 -0600
Subject: [PATCH] PCI: designware: Fix IO resource end address calculation
In-Reply-To: <1411482540-31297-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <1411482540-31297-2-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <20140923225356.GG27117@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Mohit, Jingoo]

On Tue, Sep 23, 2014 at 10:28:57PM +0800, Minghuan Lian wrote:
> End address should be equal to start_addr + size - 1.
> The patch fixes PCI IO resource end address calculation.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  drivers/pci/host/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 0f3cb2a..c19184f7 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -459,7 +459,7 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
>  			pp->io.end = min_t(resource_size_t,
>  					   IO_SPACE_LIMIT,
>  					   range.pci_addr + range.size
> -					   + global_io_offset);
> +					   + global_io_offset - 1);
>  			pp->io_size = resource_size(&pp->io);
>  			pp->io_bus_addr = range.pci_addr;
>  			pp->io_base = range.cpu_addr;
> -- 
> 1.9.1
> 
