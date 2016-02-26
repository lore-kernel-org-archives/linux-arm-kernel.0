From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 26 Feb 2016 13:31:25 -0600
Subject: [PATCH] PCI: mvebu: Restrict build to 32-bit ARM
In-Reply-To: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
References: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20160226193125.GA16330@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 02:32:10PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This driver uses PCI glue that is only available on 32-bit ARM. This
> used to work fine as long as ARCH_MVEBU and ARCH_DOVE were exclusively
> 32-bit, but that's changed now, with ARCH_MVEBU also being available
> on 64-bit ARM.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

I applied this with Thomas' ack to my for-linus branch for v4.5, thanks
Thierry!

> ---
>  drivers/pci/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 75a605426538..d1cdd9c992ac 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -14,6 +14,7 @@ config PCI_DRA7XX
>  config PCI_MVEBU
>  	bool "Marvell EBU PCIe controller"
>  	depends on ARCH_MVEBU || ARCH_DOVE
> +	depends on ARM
>  	depends on OF
>  
>  config PCIE_DW
> -- 
> 2.7.1
> 
