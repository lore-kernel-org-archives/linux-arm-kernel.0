From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 10:35:27 +0000
Subject: [PATCHv2 07/25] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
 outbound window
In-Reply-To: <20181120092615.11680-8-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-8-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB223579F27C305AD96ABC4202E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
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
> Subject: [PATCHv2 07/25] PCI: mobiveil: use WIN_NUM_0 explicitly for CFG
> outbound window
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> As the .map_bus() use the WIN_NUM_0 for CFG transactions, it's better
> passing WIN_NUM_0 explicitly when initialize the CFG outbound window.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
> 
>  drivers/pci/controller/pcie-mobiveil.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index b2cc9c097fc9..df71c11b4810 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -612,9 +612,8 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	 */
> 
>  	/* config outbound translation window */
> -	program_ob_windows(pcie, pcie->ob_wins_configured,
> -			   pcie->ob_io_res->start, 0, CFG_WINDOW_TYPE,
> -			   resource_size(pcie->ob_io_res));
> +	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
> +			   CFG_WINDOW_TYPE, resource_size(pcie-
> >ob_io_res));
> 
>  	/* memory inbound translation window */
>  	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE);
> --
> 2.17.1
