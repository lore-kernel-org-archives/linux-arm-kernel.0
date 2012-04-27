From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 27 Apr 2012 16:41:10 +0800
Subject: [PATCH 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <1335514900.31825.132.camel@vkoul-udesk3>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-2-git-send-email-richard.zhao@freescale.com>
 <1335514900.31825.132.camel@vkoul-udesk3>
Message-ID: <20120427084109.GO28063@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 01:51:40PM +0530, Vinod Koul wrote:
> On Fri, 2012-04-27 at 15:02 +0800, Richard Zhao wrote:
> > device_prep_dma_cyclic may be call in audio trigger function which is
> > atomic context, so we make it atomic too.
> No this is wrong behavior. You should not call dma prepare functions in
> any of the sound trigger calls. It would make sense to move this in
> sound prepare callback.
Then, could you please doc it somewhere? I think I'm not the only one
confused.

Thanks
Richard
> 
> -- 
> ~Vinod
> 
> 
