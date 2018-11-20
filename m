From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 11:27:24 +0000
Subject: [PATCHv2 20/25] PCI: mobiveil: add Byte and Half-Word width
 register accessors
In-Reply-To: <20181120092615.11680-21-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-21-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB22354FEF2BDCCF9725FD81C5E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:28 PM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 20/25] PCI: mobiveil: add Byte and Half-Word width
> register accessors
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> As there are some Byte and Half-Work width registers in PCIe configuration
> space, add Byte and Half-Word width register accessors.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
> 
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 81685840b378..933c2f34bc52 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -181,9 +181,29 @@ static inline u32 csr_readl(struct mobiveil_pcie *pcie,
> u32 off)
>  	return csr_read(pcie, off, 0x4);
>  }
> 
> +static inline u32 csr_readw(struct mobiveil_pcie *pcie, u32 off) {
> +	return csr_read(pcie, off, 0x2);
> +}
> +
> +static inline u32 csr_readb(struct mobiveil_pcie *pcie, u32 off) {
> +	return csr_read(pcie, off, 0x1);
> +}
> +
>  static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)  {
>  	csr_write(pcie, val, off, 0x4);
>  }
> 
> +static inline void csr_writew(struct mobiveil_pcie *pcie, u32 val, u32
> +off) {
> +	csr_write(pcie, val, off, 0x2);
> +}
> +
> +static inline void csr_writeb(struct mobiveil_pcie *pcie, u32 val, u32
> +off) {
> +	csr_write(pcie, val, off, 0x1);
> +}
> +
>  #endif /* _PCIE_MOBIVEIL_H */
> --
> 2.17.1
