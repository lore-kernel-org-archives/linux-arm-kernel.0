From: minghuan.lian@nxp.com (M.h. Lian)
Date: Thu, 2 Nov 2017 09:31:33 +0000
Subject: [PATCH 3/3] ARMv8: pcie: make the DWC EP driver support for
 layerscape
In-Reply-To: <20171024083045.31135-4-xiaowei.bao@nxp.com>
References: <20171024083045.31135-1-xiaowei.bao@nxp.com>
 <20171024083045.31135-4-xiaowei.bao@nxp.com>
Message-ID: <VI1PR04MB1615DB65A3A9E50B4B31476CE85C0@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Bao Xiaowei [mailto:xiaowei.bao at nxp.com]
> Sent: Tuesday, October 24, 2017 4:31 PM
> To: robh+dt at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
> will.deacon at arm.com; bhelgaas at google.com; shawnguo at kernel.org;
> Madalin-cristian Bucur <madalin.bucur@nxp.com>; Sumit Garg
> <sumit.garg@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; hongtao.jia at nxp.com;
> Andy Tang <andy.tang@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> kishon at ti.com; jingoohan1 at gmail.com; pbrobinson at gmail.com;
> songxiaowei at hisilicon.com; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> pci at vger.kernel.org; linuxppc-dev at lists.ozlabs.org; Z.q. Hou
> <zhiqiang.hou@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>
> Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
> Subject: [PATCH 3/3] ARMv8: pcie: make the DWC EP driver support for
> layerscape
> 
> Layerscape pcie controllers support RC or EP mode, Add the EP mode support in
> Kconfig, the driver will support both RC and EP mode, and the driver is able to
> judge the pcie controllers work on RC or EP mode.
> 
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> ---
>  drivers/pci/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig index
> 22ec82fcdea2..b5f507795779 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -108,6 +108,7 @@ config PCI_LAYERSCAPE
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select MFD_SYSCON
>  	select PCIE_DW_HOST
> +	select PCIE_DW_EP
>  	help
>  	  Say Y here if you want PCIe controller support on Layerscape SoCs.
> 
> --
> 2.14.1
