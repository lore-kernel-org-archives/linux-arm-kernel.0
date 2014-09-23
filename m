From: scottwood@freescale.com (Scott Wood)
Date: Tue, 23 Sep 2014 16:25:11 -0500
Subject: [PATCH v3 3/3] PCI: Layerscape: Add Layerscape PCIe driver
In-Reply-To: <1411482540-31297-5-git-send-email-Minghuan.Lian@freescale.com>
References: <1411482540-31297-1-git-send-email-Minghuan.Lian@freescale.com>
 <1411482540-31297-5-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <1411507511.13320.155.camel@snotra.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-23 at 22:29 +0800, Minghuan Lian wrote:
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 34134d6..7c49456 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -82,4 +82,11 @@ config PCIE_XILINX
>  	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
>  	  Host Bridge driver.
>  
> +config PCI_LAYERSCAPE
> +	bool "Freescale Layerscape PCIe controller"
> +	select PCIE_DW
> +	select MFD_SYSCON
> +	help
> +	  Say Y here if you want PCIe controller support on Layerscape SoCs.
> +
>  endmenu

Are you sure there are no dependencies for this to build?  At the least
you need OF.

I think you should also be selecting REGMAP.

-Scott
