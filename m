From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 11:24:53 +0000
Subject: [PATCHv2 14/25] PCI: mobiveil: initialize
 Primary/Secondary/Subordinate bus number
In-Reply-To: <20181120092615.11680-15-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-15-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB22353443B478CFD95466B664E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:27 PM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 14/25] PCI: mobiveil: initialize
> Primary/Secondary/Subordinate bus number
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The reset value is all zero, so set a workable value for Primary, Secondary
> and Subordinate bus numbers.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
> 
>  drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index db7ecb021c63..9210165fe8c0 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -582,6 +582,12 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	u32 value, pab_ctrl, type;
>  	struct resource_entry *win;
> 
> +	/* setup bus numbers */
> +	value = csr_readl(pcie, PCI_PRIMARY_BUS);
> +	value &= 0xff000000;
> +	value |= 0x00ff0100;
> +	csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +
>  	/*
>  	 * program Bus Master Enable Bit in Command Register in PAB Config
>  	 * Space
> --
> 2.17.1
