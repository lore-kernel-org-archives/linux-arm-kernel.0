From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 3 Nov 2015 08:44:01 -0600
Subject: [PATCH] PCI: altera: add OF_PCI dependency
In-Reply-To: <38421064.oVjju5M930@wuerfel>
References: <38421064.oVjju5M930@wuerfel>
Message-ID: <20151103144401.GA17786@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 03:08:33PM +0100, Arnd Bergmann wrote:
> The newly added altera PCI driver fails to build when CONFIG_OF
> is disabled:
> 
> drivers/pci/host/pcie-altera.c: In function 'altera_pcie_parse_request_of_pci_ranges':
> drivers/pci/host/pcie-altera.c:420:8: error: implicit declaration of function 'of_pci_get_host_bridge_resources' [-Werror=implicit-function-declaration]
> 
> This adds a dependency on OF_PCI for clarity, this is the symbol
> that guards the implementation of of_pci_get_host_bridge_resources.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 6bb4dd154ae8 ("PCI: altera: Add Altera PCIe host controller driver")

6bb4dd154ae8 hasn't been merged into mainline yet, so I folded this fix
into it.  Thanks, Arnd!

> ---
> Found on ARM randconfig builds yesterday
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 9e24075d83f7..f131ba947dc6 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -150,6 +150,7 @@ config PCIE_IPROC_BCMA
>  config PCIE_ALTERA
>  	bool "Altera PCIe controller"
>  	depends on ARM || NIOS2
> +	depends on OF_PCI
>  	select PCI_DOMAINS
>  	help
>  	  Say Y here if you want to enable PCIe controller support on Altera
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
