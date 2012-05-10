From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 10 May 2012 09:23:58 +0530
Subject: [PATCH V2 01/11] dma: imx-sdma: make channel0 operations atomic
In-Reply-To: <1336563190-19974-2-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-2-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336622038.1540.285.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-09 at 19:33 +0800, Richard Zhao wrote:
> device_prep_dma_cyclic may be call in audio trigger function which is
> atomic context, so we make it atomic too.
> 
>  - change channel0 lock to spinlock.
>  - Use polling to wait for channel0 finish running.
> 
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked By: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
