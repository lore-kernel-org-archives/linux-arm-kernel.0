From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Tue, 28 Jul 2015 15:14:01 +0000
Subject: [PATCH v6 2/2] ARM: imx: Add suspend codes for imx7D
In-Reply-To: <20150728143045.GG12927@tiger>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-3-git-send-email-shenwei.wang@freescale.com>
 <20150727132802.GK12927@tiger>
 <CY1PR0301MB084353EB59E199271D536F68838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <20150728010235.GU12927@tiger>
 <CY1PR0301MB0843D0437575B34EE569F50A838D0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <20150728143045.GG12927@tiger>
Message-ID: <CY1PR0301MB084365339B13A858A0B5AAC9838D0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2015?7?28? 9:31
> To: Wang Shenwei-B38339
> Cc: jason at lakedaemon.net; Huang Yongcai-B20788;
> linux-kernel at vger.kernel.org; tglx at linutronix.de; shawn.guo at linaro.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v6 2/2] ARM: imx: Add suspend codes for imx7D
> 
> On Tue, Jul 28, 2015 at 02:16:20PM +0000, Shenwei Wang wrote:
> > > The files are named with "-imx7".  It's a clear sign that the build
> > > of the files should be controlled by something like related to "imx7".
> > > Ideally, it should be CONFIG_SOC_IMX7.  Since imx7d is the only
> > > supported imx7 soc and there is no CONFIG_SOC_IMX7 available so far,
> > > it falls on CONFIG_SOC_IMX7D.
> >
> > We can also interpret "-imx7" is the first SoC which has the GPCv2 block.
> 
> In that case you should name the block gpc-imx7d rather than gpcv2 and symbol
> as GPC_IMX7D rather than IMX_GPCV2.

I don't want to couple the gpcv2 driver with a SoC. Let's use your suggestion CONFIG_SOC_IMX7D
for now, because it introduce less modifications.
 
> > > > > > +extern struct imx_gpcv2_irq *gpcv2_irq_instance;
> > > > >
> > > > > Will this give a checkpatch warning?
> > > >
> > > > Yes. Any suggestion for that? Move it to a header file?
> > >
> > > Get rid of it.
> >
> > Then you may resolve the following compile error:
> 
> You didn't get my point.  Rather than defining it as a global variable, we should
> try to keep imx_gpcv2_irq as an internal data structure to irqchip driver, and use
> well-defined interface to access the data from pm driver when necessary.

Either to export a variable or a function, you will finally meet the same problem
:where to declare it? Otherwise the same compile error will happen too.

Regards,
Shenwei
 

> Shawn
> 
> >
> > CC      arch/arm/mach-imx/pm-imx7.o
> > arch/arm/mach-imx/pm-imx7.c: In function ?imx_gpcv2_pm_init?:
> > arch/arm/mach-imx/pm-imx7.c:836:7: error: ?gpcv2_irq_instance? undeclared
> (first use in this function)
> >   cd = gpcv2_irq_instance;
> >        ^
> > arch/arm/mach-imx/pm-imx7.c:836:7: note: each undeclared identifier is
> > reported only once for each function it appears in
> > make[1]: *** [arch/arm/mach-imx/pm-imx7.o] Error 1
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ULP1 3rd Party Tools Requirements.xlsx
Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
Size: 19256 bytes
Desc: ULP1 3rd Party Tools Requirements.xlsx
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150728/02174255/attachment-0001.xlsx>
