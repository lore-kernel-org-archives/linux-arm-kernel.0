From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 20:37:54 +0800
Subject: [PATCH V2 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <20120510063446.GA17875@S2101-09.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-2-git-send-email-richard.zhao@freescale.com>
 <1336622038.1540.285.camel@vkoul-udesk3>
 <20120510063446.GA17875@S2101-09.ap.freescale.net>
Message-ID: <20120510123749.GO17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 02:34:49PM +0800, Shawn Guo wrote:
> On Thu, May 10, 2012 at 09:23:58AM +0530, Vinod Koul wrote:
> > On Wed, 2012-05-09 at 19:33 +0800, Richard Zhao wrote:
> > > device_prep_dma_cyclic may be call in audio trigger function which is
> > > atomic context, so we make it atomic too.
> > > 
> > >  - change channel0 lock to spinlock.
> > >  - Use polling to wait for channel0 finish running.
> > > 
> > > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > Acked By: Vinod Koul <vinod.koul@linux.intel.com>
> > 
> Applied on imx/dt branch with Vinod's ack.  Thanks.
> 
Hi Vinod,

Since Mark wouldn't like to have sound tree pulled into arm-soc to help
a couple of patches in the series get merged in the coming window, I can
not take the series as a whole to go with arm-soc.  It makes less sense
to have this patch go arm-soc then, so please take the patch.

-- 
Regards,
Shawn
