From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 23 Sep 2013 09:55:49 +0530
Subject: [PATCH 3/3] dma: Add Freescale eDMA engine driver support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E85223E21@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378374799-16357-1-git-send-email-b35083@freescale.com>
 <20130917045359.GN17188@intel.com>
 <B56CDBE15CE27145A4B77D2D24263E85223E21@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20130923042549.GC17188@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 08:08:46AM +0000, Lu Jingchang-B35083 wrote:
> > > +	case DMA_PAUSE:
> > > +		if (fsl_chan->edesc)
> > > +			fsl_edma_disable_request(fsl_chan);
> > racy here too...
> It only set the channel HW register, no list is handled, 
> is lock needed here? Thanks!
well thats the point while you are terminating the current trasnaction can
complete and then start another one. You want to try and prevent these case
also. Here you are neither locking the HW access nor the the list, so its juts
waiting to crash!

~Vinod
-- 
