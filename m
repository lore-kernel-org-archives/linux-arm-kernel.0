From: minghuan.lian@nxp.com (M.h. Lian)
Date: Thu, 2 Nov 2017 08:54:29 +0000
Subject: [PATCH 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
In-Reply-To: <20171024083045.31135-2-xiaowei.bao@nxp.com>
References: <20171024083045.31135-1-xiaowei.bao@nxp.com>
 <20171024083045.31135-2-xiaowei.bao@nxp.com>
Message-ID: <VI1PR04MB16150087206A5385F52D163CE85C0@VI1PR04MB1615.eurprd04.prod.outlook.com>
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
> Subject: [PATCH 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
> 
> Add the property of inbind and outbind windows number for ep driver.
> 
> add the inband or outband window entry for pcie controller ep driver used in dts.
> 
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 06b5e12d04d8..f8332669663c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -674,6 +674,8 @@
>  			device_type = "pci";
>  			dma-coherent;
>  			num-lanes = <4>;
> +			num-ib-windows = <6>;
> +			num-ob-windows = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x40
> 0x00010000 0x0 0x00010000   /* downstream I/O */
>  				  0x82000000 0x0 0x40000000 0x40
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */ @@ -699,6
> +701,8 @@
>  			device_type = "pci";
>  			dma-coherent;
>  			num-lanes = <2>;
> +			num-ib-windows = <6>;
> +			num-ob-windows = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x48
> 0x00010000 0x0 0x00010000   /* downstream I/O */
>  				  0x82000000 0x0 0x40000000 0x48
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */ @@ -724,6
> +728,8 @@
>  			device_type = "pci";
>  			dma-coherent;
>  			num-lanes = <2>;
> +			num-ib-windows = <6>;
> +			num-ob-windows = <6>;
>  			bus-range = <0x0 0xff>;
>  			ranges = <0x81000000 0x0 0x00000000 0x50
> 0x00010000 0x0 0x00010000   /* downstream I/O */
>  				  0x82000000 0x0 0x40000000 0x50
> 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> --
> 2.14.1
