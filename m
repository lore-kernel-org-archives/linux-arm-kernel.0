From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 10:33:42 +0000
Subject: [PATCHv2 04/25] PCI: mobiveil: remove flag MSI_FLAG_MULTI_PCI_MSI
In-Reply-To: <20181120092615.11680-5-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-5-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB22350E24ECD8F70877D7FEF6E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:26 PM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 04/25] PCI: mobiveil: remove flag
> MSI_FLAG_MULTI_PCI_MSI
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The current code does not support multiple MSIs, so remove the
> corresponding flag from the msi_domain_info structure.
> 
> Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - Added fixes entry.
> 
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index 563210e731d3..a0dd337c6214 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -703,7 +703,7 @@ static struct irq_chip mobiveil_msi_irq_chip = {
> 
>  static struct msi_domain_info mobiveil_msi_domain_info = {
>  	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS |
> -		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
> +		   MSI_FLAG_PCI_MSIX),
>  	.chip	= &mobiveil_msi_irq_chip,
>  };
> 
> --
> 2.17.1
