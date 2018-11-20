From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 10:59:52 +0000
Subject: [PATCHv2 08/25] PCI: mobiveil: use the 1st inbound window for MEM
 inbound transactions
In-Reply-To: <20181120092615.11680-9-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-9-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB223585D8755A5B5DF6EBC22AE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
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
> Subject: [PATCHv2 08/25] PCI: mobiveil: use the 1st inbound window for
> MEM inbound transactions
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The inbound windows have different register set with outbound windows.
> This patch change the MEM inbound window to the first one.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
> 
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index df71c11b4810..e88afc792a5c 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -616,7 +616,7 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  			   CFG_WINDOW_TYPE, resource_size(pcie-
> >ob_io_res));
> 
>  	/* memory inbound translation window */
> -	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE);
> +	program_ib_windows(pcie, WIN_NUM_0, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE);
> 
>  	/* Get the I/O and memory ranges from DT */
>  	resource_list_for_each_entry(win, &pcie->resources) {
> --
> 2.17.1
