From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Tue, 19 Jul 2011 09:20:42 +0000
Subject: [PATCH 1/1] ARM: mxs-dma: reset after disable channel
In-Reply-To: <20110719084536.GH3838@S2100-06.ap.freescale.net>
References: <1311048596-19932-1-git-send-email-b29396@freescale.com>
	<20110719040215.GF3838@S2100-06.ap.freescale.net>
	<20110719082146.GA1951@pengutronix.de>
	<20110719084536.GH3838@S2100-06.ap.freescale.net>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721E752A@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Guo Shawn-R65073
> Sent: Tuesday, July 19, 2011 4:46 PM
> To: Wolfram Sang
> Cc: Dong Aisheng-B29396; vinod.koul at intel.com; shawn.guo at linaro.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/1] ARM: mxs-dma: reset after disable channel
> 
> On Tue, Jul 19, 2011 at 10:21:46AM +0200, Wolfram Sang wrote:
> > On Tue, Jul 19, 2011 at 12:02:16PM +0800, Shawn Guo wrote:
> > > On Tue, Jul 19, 2011 at 12:09:56PM +0800, Dong Aisheng wrote:
> > > > We met some channels in abnormal state after disable.
> > > > Reset it to get a clean state.
> > > >
> > > > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > > > Cc: Vinod Koul <vinod.koul@intel.com>
> > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > ---
> > >
> > > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> >
> > Just to make sure: Did you investigate where the "abnormal" state came
> > from and if that could be fixed?
> >
> I suppose this is a question for Aisheng, as he is the one who actually
> saw the "abnormal" state.  But since mxs_dma_disable_chan() is being
> called in mxs_dma_control(DMA_TERMINATE_ALL) for case audio, it's should
> be pretty safe reset the channel here.

It looked like the dma was not stopped properly, it maybe still running.
So the next time we allocated DMA chan, a dma interrupt would be generated
Before channel was starting.

I may check if we can find the root cause.

Regards
Dong Aisheng 
