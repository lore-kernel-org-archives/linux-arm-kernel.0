From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Mon, 23 Sep 2013 06:56:37 +0000
Subject: [PATCH 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20130923042549.GC17188@intel.com>
References: <1378374799-16357-1-git-send-email-b35083@freescale.com>
 <20130917045359.GN17188@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E85223E21@039-SN1MPN1-003.039d.mgd.msft.net>
 <20130923042549.GC17188@intel.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E852260F9@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Monday, September 23, 2013 12:26 PM
> To: Lu Jingchang-B35083
> Cc: djbw at fb.com; shawn.guo at linaro.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org
> Subject: Re: [PATCH 3/3] dma: Add Freescale eDMA engine driver support
> 
> On Tue, Sep 17, 2013 at 08:08:46AM +0000, Lu Jingchang-B35083 wrote:
> > > > +	case DMA_PAUSE:
> > > > +		if (fsl_chan->edesc)
> > > > +			fsl_edma_disable_request(fsl_chan);
> > > racy here too...
> > It only set the channel HW register, no list is handled,
> > is lock needed here? Thanks!
> well thats the point while you are terminating the current trasnaction
> can
> complete and then start another one. You want to try and prevent these
> case
> also. Here you are neither locking the HW access nor the the list, so its
> juts
> waiting to crash!
Thanks! I have sent out the new v6 patch last week with holding lock here,
Could you please help review it?


Best Regards,
Jingchang
