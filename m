From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 11 May 2012 14:03:57 +0530
Subject: [alsa-devel] [PATCH Rebase 1/1] dma: imx-sdma: make channel0
 operations atomic
In-Reply-To: <1336720467-29770-1-git-send-email-richard.zhao@freescale.com>
References: <1336717928.15424.1597.camel@vkoul-udesk3>
 <1336720467-29770-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336725237.15424.1840.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-11 at 15:14 +0800, Richard Zhao wrote:
> device_prep_dma_cyclic may be call in audio trigger function which is
> atomic context, so we make it atomic too.
> 
>  - change channel0 lock to spinlock.
>  - Use polling to wait for channel0 finish running.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Thanks, Applied to slave-dma -next.

-- 
~Vinod
