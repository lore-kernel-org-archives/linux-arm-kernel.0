From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 22 Jul 2014 12:27:10 -0600
Subject: [PATCH v2 09/12] PCI: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1405028192-9623-10-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
 <1405028192-9623-10-git-send-email-andrew@lunn.ch>
Message-ID: <20140722182710.GA19181@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 11:36:29PM +0200, Andrew Lunn wrote:
> mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
> ARCH_MVEBU is sufficient.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Applied with Jason's ack to pci/host-mvebu for v3.17, thanks!

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci at vger.kernel.org
> ---
>  drivers/pci/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 21df477be0c8..88f4862fa452 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -3,7 +3,7 @@ menu "PCI host controller drivers"
>  
>  config PCI_MVEBU
>  	bool "Marvell EBU PCIe controller"
> -	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_KIRKWOOD
> +	depends on ARCH_MVEBU || ARCH_DOVE
>  	depends on OF
>  
>  config PCIE_DW
> -- 
> 2.0.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
