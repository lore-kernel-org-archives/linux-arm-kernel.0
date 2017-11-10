From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 10 Nov 2017 21:20:31 +0000
Subject: [PATCHv4 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
In-Reply-To: <20b8f1d2-f817-469f-afbf-66f25d6f8c46@ti.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
 <20171110034847.17891-2-xiaowei.bao@nxp.com>
 <20b8f1d2-f817-469f-afbf-66f25d6f8c46@ti.com>
Message-ID: <AM4PR0401MB16999BD34AFBB1362BD32EBD8F540@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Kishon Vijay Abraham I [mailto:kishon at ti.com]
> Sent: Friday, November 10, 2017 12:22 AM
> To: Xiaowei Bao <xiaowei.bao@nxp.com>; robh+dt at kernel.org;
> mark.rutland at arm.com; catalin.marinas at arm.com; will.deacon at arm.com;
> bhelgaas at google.com; shawnguo at kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Sumit Garg <sumit.garg@nxp.com>; Y.b. Lu
> <yangbo.lu@nxp.com>; hongtao.jia at nxp.com; Andy Tang
> <andy.tang@nxp.com>; Leo Li <leoyang.li@nxp.com>; jingoohan1 at gmail.com;
> pbrobinson at gmail.com; songxiaowei at hisilicon.com;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; linux-pci at vger.kernel.org; linuxppc-
> dev at lists.ozlabs.org; Z.q. Hou <zhiqiang.hou@nxp.com>; Mingkai Hu
> <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>
> Subject: Re: [PATCHv4 1/3] ARMv8: dts: ls1046a: add the property of IB and OB
> 
> Hi Bao,
> 
> On Friday 10 November 2017 09:18 AM, Bao Xiaowei wrote:
> > Add the property of inbound and outbound windows number for ep driver.
> >
> > Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> > Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>
> > ---
> >  v2:
> >  - no change
> >  v3:
> >  - modify the commit message
> >  v4:
> >  - no change
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> $subject should start with something like
> arm64: dts: ls1046a: **
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > index 06b5e12d04d8..f8332669663c 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> > @@ -674,6 +674,8 @@
> >  			device_type = "pci";
> >  			dma-coherent;
> >  			num-lanes = <4>;
> > +			num-ib-windows = <6>;
> > +			num-ob-windows = <6>;
> 
> EP specific properties shouldn't be added in RC dt node. Ideally you should have
> a separate dt node for RC and EP.

It is a single PCIe controller which can be configured to either RC mode or EP mode.  Wouldn't it conflict with the device tree principles to have two device tree nodes for the same PCIe controller?  And obviously the two modes cannot be used at the same time so we cannot have two drivers both probe on the same hardware.

Regards,
Leo
