From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 23 Apr 2012 16:02:21 +0800
Subject: [PATCH 3/5] dma: mxs-dma: add device tree probe support
In-Reply-To: <20120423050358.GL26306@S2101-09.ap.freescale.net>
References: <1334753197-12032-1-git-send-email-b29396@freescale.com>
 <1334753197-12032-4-git-send-email-b29396@freescale.com>
 <20120423031518.GJ26306@S2101-09.ap.freescale.net>
 <20120423040129.GC24843@shlinux2.ap.freescale.net>
 <20120423050358.GL26306@S2101-09.ap.freescale.net>
Message-ID: <20120423080220.GE24843@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 01:04:00PM +0800, Shawn Guo wrote:
> On Mon, Apr 23, 2012 at 12:01:29PM +0800, Dong Aisheng wrote:
> > > > +#ifdef CONFIG_OF
> > > > +static const struct of_device_id mxs_dma_dt_ids[] = {
> > > > +	{ .compatible = "fsl,imx23-dma-apbh", .data = &mxs_dma_idt[0], },
> > > > +	{ .compatible = "fsl,imx23-dma-apbx", .data = &mxs_dma_idt[1], },
> > > > +	{ .compatible = "fsl,imx28-dma-apbh", .data = &mxs_dma_idt[2], },
> > > > +	{ .compatible = "fsl,imx28-dma-apbx", .data = &mxs_dma_idt[3], },
> > > > +	{ /* sentinel */ }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, mxs_dma_dt_ids);
> > > > +#endif
> > > > +
> > > As out goal is to convert mxs over to DT, you can remove the #ifdef
> > > here ...
> > > 
> > But the non-dt is still exist, right?
> > So i think we can keep it now unless we totally removed the non-dt code.
> > 
> The non-dt still exist during the transition.  But even without the
> #ifdef, the driver works for non-dt.  It just saves a few bytes for
> non-dt only build.  We will soon enable DT build for mxs permanently.
> What's the point to have it at all?
> 
Hmm, i think the point is non-dt does not need it, not relate to whether
user decide to enable dt or not.
Since you insist that, i can remove it first in my v2 patch and see people's
comment.

Regards
Dong Aisheng
