From: vinod.koul@intel.com (Koul, Vinod)
Date: Tue, 24 May 2011 21:36:11 +0530
Subject: [PATCH] dmaengine: Add API documentation for slave dma usage
In-Reply-To: <BANLkTikDPeEFWdsVQ=Ak8jXEXsC-+uoOaw@mail.gmail.com>
References: <1306238657-30089-1-git-send-email-vinod.koul@intel.com>
	<BANLkTikDPeEFWdsVQ=Ak8jXEXsC-+uoOaw@mail.gmail.com>
Message-ID: <1306253171.30236.9.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-24 at 17:40 +0200, Per Forlin wrote:
> Hi Vinod,
> 
> On Tue, May 24, 2011 at 2:04 PM, Koul, Vinod <vinod.koul@intel.com> wrote:
> > From: Vinod Koul <vinod.koul@intel.com>
> >
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  Documentation/dma-slave-api.txt |   74 +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 74 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/dma-slave-api.txt
> I suggest putting this in subsection of dmaengine.txt instead.
> dmaengine.txt would be the natural place to look at.
Agreed, that would make it easier for people to find

> > +4. Submit the transaction(s) and wait for callback notification when slave API
> > +is 3 above returns, the non NULL value would imply a "descriptor" for the
> > +transaction. These transaction(s) would need to be submitted which pushes them
> > +into queue in DMA driver. If DMA is idle then the first descriptor submit will
> > +be pushed to DMA and subsequent ones will be queued. On completion of the DMA
> > +operation the next in queue is submitted and a tasklet triggered. The tasklet
> > +would then call the client driver completion callback routine for notification,
> > +if set.
> > +
> Does submit really start the transfer as well? My interpretation of
> submit is that is only adds desc to a pending queue. When calling
> issue_pending all these descs will be schedule for DMA transfer. Calls
> to submit after this point will added to the pending queue again and
> not be issued until calling issue_pending once more.
For slave dma devices, submit() is used to start the transaction if the
channel is idle. If its already doing a transaction then it will queue
it up and submit once cureent excuting one is completed. It is not
required to call issue_pending once more.
I am not sure if this is true for non slave usage, Dan would that be
correct for you as well?

-- 
~Vinod
