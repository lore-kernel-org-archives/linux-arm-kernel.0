From: yao.yuan@freescale.com (Yao Yuan)
Date: Wed, 15 Jul 2015 10:29:55 +0000
Subject: [PATCH] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <3074236.7KNCYXgBBY@wuerfel>
References: <1436952778-28000-1-git-send-email-yao.yuan@freescale.com>
 <1436952778-28000-2-git-send-email-yao.yuan@freescale.com>
 <3074236.7KNCYXgBBY@wuerfel>
Message-ID: <BL2PR03MB338DF493E475876FF6C6038839A0@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for your review.
And can you give me more information?
In my opinion, The fsl_edma_pm_state will just be used when CONFIG_PM support. So why not use the #ifdefs to remove the 
unnecessary code? Since the PM will not be selected in many use cases.

Thanks.

Best Regards,
Yuan Yao

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Wednesday, July 15, 2015 5:57 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Yuan Yao-B46683; vinod.koul at intel.com; stefan at agner.ch;
> dmaengine at vger.kernel.org; dan.j.williams at intel.com; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH] dmaengine: fsl-edma: add PM suspend/resume support
> 
> On Wednesday 15 July 2015 17:32:58 Yuan Yao wrote:
> > +#ifdef CONFIG_PM
> > +enum fsl_edma_pm_state {
> > +       RUNNING = 0,
> > +       SUSPENDED,
> > +};
> > +#endif
> >
> >  struct fsl_edma_hw_tcd {
> >
> 
> The #ifdefs here seem unnecessary, at least most of them, better just do this
> all unconditionally.
> 
> 	Arnd
