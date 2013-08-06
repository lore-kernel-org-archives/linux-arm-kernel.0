From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 6 Aug 2013 01:24:31 +0000
Subject: [PATCH v2 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20130805163444.GQ29095@intel.com>
References: <1375682824-11443-1-git-send-email-b35083@freescale.com>
 <1375682824-11443-2-git-send-email-b35083@freescale.com>
 <20130805163444.GQ29095@intel.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851FD63C@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Tuesday, August 06, 2013 12:35 AM
> To: Lu Jingchang-B35083
> Cc: djbw at fb.com; shawn.guo at linaro.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; Wang Huan-B18965; Li Xiaochun-
> B41219
> Subject: Re: [PATCH v2 3/3] dma: Add Freescale eDMA engine driver support
> > +
> > +static void fsl_edma_free_desc(struct virt_dma_desc *vdesc) {
> > +	struct fsl_edma_desc *fsl_desc;
> > +	int i;
> > +
> > +	fsl_desc = to_fsl_edma_desc(vdesc);
> > +	for (i = 0; i < fsl_desc->n_tcds; i++)
> > +			dma_pool_free(fsl_desc->echan->tcd_pool,
> > +					fsl_desc->tcd[i].vtcd,
> > +					fsl_desc->tcd[i].ptcd);
> > +	kfree(fsl_desc);
> should this be called with lock held or not?
[Lu Jingchang-B35083] 
The desc list to be freed is got with lock held, and the free for each desc is independent, and the lock is not needed. Thanks.






Best Regards,
Jingchang
