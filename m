From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 27 Apr 2012 15:52:10 +0530
Subject: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <20120427084109.GO28063@b20223-02.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <1335514900.31825.132.camel@vkoul-udesk3>
 <20120427084109.GO28063@b20223-02.ap.freescale.net>
Message-ID: <1335522130.31825.135.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-04-27 at 16:41 +0800, Richard Zhao wrote:
> On Fri, Apr 27, 2012 at 01:51:40PM +0530, Vinod Koul wrote:
> > On Fri, 2012-04-27 at 15:02 +0800, Richard Zhao wrote:
> > > device_prep_dma_cyclic may be call in audio trigger function which is
> > > atomic context, so we make it atomic too.
> > No this is wrong behavior. You should not call dma prepare functions in
> > any of the sound trigger calls. It would make sense to move this in
> > sound prepare callback.
> Then, could you please doc it somewhere? I think I'm not the only one
> confused.
See the soc-dmaengine.c for correct behavior!
I can document only dmaengine behavior (which is already there) and not
how each subsystem should use this. People is subsystems need to see how
to use the dmaengine APIs sanely


-- 
~Vinod
