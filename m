From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 17 Sep 2013 08:08:46 +0000
Subject: [PATCH 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <20130917045359.GN17188@intel.com>
References: <1378374799-16357-1-git-send-email-b35083@freescale.com>
 <20130917045359.GN17188@intel.com>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E85223E21@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Vinod Koul [mailto:vinod.koul at intel.com]
> Sent: Tuesday, September 17, 2013 12:54 PM
> To: Lu Jingchang-B35083
> Cc: djbw at fb.com; shawn.guo at linaro.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; Wang
> Huan-B18965
> Subject: Re: [PATCH 3/3] dma: Add Freescale eDMA engine driver support
> > +	case DMA_PAUSE:
> > +		if (fsl_chan->edesc)
> > +			fsl_edma_disable_request(fsl_chan);
> racy here too...
It only set the channel HW register, no list is handled, 
is lock needed here? Thanks!






Best Regards,
Jingchang
