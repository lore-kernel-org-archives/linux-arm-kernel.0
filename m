From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 5 Sep 2017 08:42:58 -0500
Subject: [PATCH 1/2] PCI: iproc: export iproc_pcie_shutdown symbol
In-Reply-To: <20170905072004.3959082-1-arnd@arndb.de>
References: <20170905072004.3959082-1-arnd@arndb.de>
Message-ID: <20170905134258.GA14367@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 09:19:44AM +0200, Arnd Bergmann wrote:
> The shutdown bugfix introduce a build regression for allmodconfig
> kernels as the new function is not exported:
> 
> ERROR: "iproc_pcie_shutdown" [drivers/pci/host/pcie-iproc-platform.ko] undefined!
> 
> This adds the missing export.
> 
> Fixes: 2a9912565c05 ("PCI: iproc: Add 500ms delay during device shutdown")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Folded into the 2a9912565c05 commit, thanks!

> ---
>  drivers/pci/host/pcie-iproc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 8bd5e544b1c1..d7f4c29aed96 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -704,6 +704,7 @@ int iproc_pcie_shutdown(struct iproc_pcie *pcie)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(iproc_pcie_shutdown);
>  
>  static int iproc_pcie_check_link(struct iproc_pcie *pcie)
>  {
> -- 
> 2.9.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
