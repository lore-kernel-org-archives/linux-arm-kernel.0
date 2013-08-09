From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 9 Aug 2013 08:38:26 -0300
Subject: [PATCH] PCI: mvebu: make Marvell PCIe driver depend on OF
In-Reply-To: <1376044550-30572-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376044550-30572-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130809113825.GD2848@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 12:35:50PM +0200, Thomas Petazzoni wrote:
> The Marvell PCIe host controller driver is heavily tied to Device Tree
> APIs, and can only be used on platforms where the Device Tree is
> used. Therefore, it should "depends on OF" to avoid build failures on
> !OF configurations.
> 
> Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

> ---
> Bjorn, you can take this one through your tree. Either for 3.11 or
> 3.12, at your preference.
> ---
>  drivers/pci/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 1184ff6..e5ba4eb 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -4,6 +4,7 @@ menu "PCI host controller drivers"
>  config PCI_MVEBU
>  	bool "Marvell EBU PCIe controller"
>  	depends on ARCH_MVEBU || ARCH_KIRKWOOD
> +	depends on OF
>  
>  config PCIE_DW
>  	bool
> -- 
> 1.8.1.2
> 

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
