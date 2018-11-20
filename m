From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 10:35:01 +0000
Subject: [PATCHv2 06/25] PCI: mobiveil: replace the resource list
 iteration function
In-Reply-To: <20181120092615.11680-7-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-7-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB2235225683B36894815AA75DE8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
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
> Subject: [PATCHv2 06/25] PCI: mobiveil: replace the resource list iteration
> function
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> As it won't delete any node in this iteration, replaced the function
> resource_list_for_each_entry_safe() with the resource_list_for_each_entry().
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
> 
>  drivers/pci/controller/pcie-mobiveil.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mobiveil.c
> b/drivers/pci/controller/pcie-mobiveil.c
> index 8ff873023b5f..b2cc9c097fc9 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -569,7 +569,7 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)  {
>  	u32 value, pab_ctrl, type;
>  	int err;
> -	struct resource_entry *win, *tmp;
> +	struct resource_entry *win;
> 
>  	err = mobiveil_bringup_link(pcie);
>  	if (err) {
> @@ -620,7 +620,7 @@ static int mobiveil_host_init(struct mobiveil_pcie
> *pcie)
>  	program_ib_windows(pcie, WIN_NUM_1, 0, MEM_WINDOW_TYPE,
> IB_WIN_SIZE);
> 
>  	/* Get the I/O and memory ranges from DT */
> -	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
> +	resource_list_for_each_entry(win, &pcie->resources) {
>  		if (resource_type(win->res) == IORESOURCE_MEM)
>  			type = MEM_WINDOW_TYPE;
>  		else if (resource_type(win->res) == IORESOURCE_IO)
> --
> 2.17.1
