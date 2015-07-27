From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Mon, 27 Jul 2015 14:50:15 +0000
Subject: [PATCH v6 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
 sources
In-Reply-To: <20150727143515.GQ12927@tiger>
References: <1437584859-64203-1-git-send-email-shenwei.wang@freescale.com>
 <1437584859-64203-2-git-send-email-shenwei.wang@freescale.com>
 <20150727134058.GL12927@tiger>
 <CY1PR0301MB084352861E63DA2DE286CC77838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <20150727143515.GQ12927@tiger>
Message-ID: <CY1PR0301MB084351380311261C292872AB838E0@CY1PR0301MB0843.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2015?7?27? 9:35
> To: Wang Shenwei-B38339
> Cc: jason at lakedaemon.net; Huang Yongcai-B20788;
> linux-kernel at vger.kernel.org; tglx at linutronix.de; shawn.guo at linaro.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v6 1/2] irqchip: imx-gpcv2: IMX GPCv2 driver for wakeup
> sources
> > > On Wed, Jul 22, 2015 at 12:07:38PM -0500, Shenwei Wang wrote:
> > > > diff --git a/include/soc/imx/gpcv2.h b/include/soc/imx/gpcv2.h new
> > > > file mode 100644 index 0000000..73d6e75
> > > > --- /dev/null
> > > > +++ b/include/soc/imx/gpcv2.h
> > >
> > > I do not like this header, which couples imx7d irqchip and pm driver
> > > so much.  Can you please elaborate why we have to have this header?
> >
> > PM driver does depend on the irqchip driver. It needs some input like
> > enabled irqs and wakeup irqs to decide which module to be powered off
> > in low power states. I am also considering if the header file could be
> > removed or not. So far it seems a common place to define a structure which is
> used in both drivers is still required.
> 
> Please be more specific.  Trimming the header down to the macros and
> structures/fields that are necessary to be in the header might be a good idea.
> And then we can go through them one by one to see if there is a way to avoid
> them being in the header.

The following structure is currently used in both drivers. The members "gpc_base/
wakeup_sources/enabled_irqs" are now shared to PM driver. And the macro IMR_NUM
will be referred by both drivers too.
 
struct imx_gpcv2_irq {
	spinlock_t lock;
	void __iomem *gpc_base;
	u32 wakeup_sources[IMR_NUM];
	u32 enabled_irqs[IMR_NUM];
	u32 cpu2wakeup;
};

Thanks,
Shenwei

> Shawn
