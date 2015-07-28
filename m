From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jul 2015 22:38:54 +0800
Subject: [PATCH v7 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <CY1PR0301MB08438D52968A601F94DBB55C838D0@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1438025400-5919-1-git-send-email-shenwei.wang@freescale.com>
 <1438025400-5919-2-git-send-email-shenwei.wang@freescale.com>
 <20150728012452.GX12927@tiger>
 <CY1PR0301MB08438D52968A601F94DBB55C838D0@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <20150728143854.GH12927@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 02:27:42PM +0000, Shenwei Wang wrote:
> > > +static int gpcv2_wakeup_source_save(void) {
> > > +	struct imx_gpcv2_irq *cd;
> > 
> > We generally name variables in an abbrev of the types to make them intuitive.  I
> > tried hard to map "cd" to "imx_gpcv2_irq" and failed.
> > Can you help me on that?
> 
> CD is the abbreviation of chip data which is a member of irq_data.

You are defining a variable of type imx_gpcv2_irq, neither chip_data nor
irq_data.

> > > +void ca7_cpu_resume(void);
> > > +void imx7_suspend(void __iomem *ocram_vbase);
> > 
> > Why do these declarations need to be in this header?
> 
> Just to resolve the compile errors.

Wrong solution.  They belong to some header in arch/arm/mach-imx not
include/soc/imx, as there is no code outside arch/arm/mach-imx needs
these declaration.

Shawn
