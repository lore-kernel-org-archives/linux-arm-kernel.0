From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 6 Nov 2017 18:11:13 -0600
Subject: [PATCH] PCI: turn off PCIe services during shutdown
In-Reply-To: <1508958063-6947-1-git-send-email-okaya@codeaurora.org>
References: <1508958063-6947-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20171107001113.GA9538@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 25, 2017 at 03:01:02PM -0400, Sinan Kaya wrote:
> Some of the PCIe services such as AER are being left enabled during
> shutdown. This might cause spurious AER errors while SOC is being
> powered down.
> 
> Let's clean up the PCIe services gracefully during shutdown to clear
> these false positives.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied to pci/portdrv for v4.15, thanks!

> ---
>  drivers/pci/pcie/portdrv_pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 083276e..b350d12 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -246,6 +246,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *dev)
>  
>  	.probe		= pcie_portdrv_probe,
>  	.remove		= pcie_portdrv_remove,
> +	.shutdown	= pcie_portdrv_remove,
>  
>  	.err_handler	= &pcie_portdrv_err_handler,
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
