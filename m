From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 17 Oct 2017 10:35:10 +0200
Subject: [PATCH 1/2] PCI: dwc: Adjust Kconfig to allow IMX6 PCIe host on
 IMX7
In-Reply-To: <20171017001159.109152-1-tpiepho@impinj.com>
References: <20171017001159.109152-1-tpiepho@impinj.com>
Message-ID: <1508229310.2146.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 16.10.2017, 17:11 -0700 schrieb Trent Piepho:
> The IMX6 PCI-e host driver also supports the IMX7d.??However, the
> Kconfig dependencies of the driver prevented it from being enabled
> unless the kernel was built with both IMX6 and IMX7 support.??It
> works
> fine to build with only IMX7 support enabled.
> 
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> CC: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ?drivers/pci/dwc/Kconfig | 4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> index 22ec82fcdea2..85cf392921a9 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -71,9 +71,9 @@ config PCI_EXYNOS
> ?	select PCIE_DW_HOST
> ?
> ?config PCI_IMX6
> -	bool "Freescale i.MX6 PCIe controller"
> +	bool "Freescale i.MX6/7 PCIe controller"
> ?	depends on PCI
> -	depends on SOC_IMX6Q
> +	depends on SOC_IMX6Q || SOC_IMX7D
> ?	depends on PCI_MSI_IRQ_DOMAIN
> ?	select PCIEPORTBUS
> ?	select PCIE_DW_HOST
