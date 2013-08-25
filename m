From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 25 Aug 2013 14:44:35 +0530
Subject: [PATCH v2 2/2] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <CAMj5BkhKwG3PuaCS=m7No9V8w2tMbeYnmJr+B_fUQJnSZW6QPw@mail.gmail.com>
References: <20130813112043.GB32147@intel.com>
 <CAMj5Bki0H+=0wQY39+jDw4nAEq5wEq3V3yri9xpNRxQ2GRwPbA@mail.gmail.com>
 <20130819053511.GU32147@intel.com>
 <CAMj5BkixUR2-MnYLVymPLnQ922jEhbKnwUHs__d3hr2d_Qb8fA@mail.gmail.com>
 <20130820082749.GG5810@intel.com> <5213359B.4070208@linaro.org>
 <20130820085037.GH5810@intel.com>
 <CAMj5Bkg_uQUgod0Cf9ZpLgX92Ys-u344BAFeHbrUwysG3pJVgw@mail.gmail.com>
 <20130821045823.GK5810@intel.com>
 <CAMj5BkhKwG3PuaCS=m7No9V8w2tMbeYnmJr+B_fUQJnSZW6QPw@mail.gmail.com>
Message-ID: <20130825091435.GI8091@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 04:02:03PM +0800, zhangfei gao wrote:
> Excuse me for my bad English.
> I am really lost and don't know what to do now.
> Are you concern:
> 1. Why need else in case DMA_PAUSE, no need?
> 2. device_tx_status is not called in audio and directly
> dmaengine_pause -> dmaengine_resume?
> 3. ?
> 
> Besides, where I should take example of amba-pl08x.c, pl08x_control,
> case DMA_PAUSE & DMA_RESUME or pl08x_dma_tx_status?
> 
> Some difference I see is k3dma.c only has one tasklet for all channels,
> The tasklet will check pending channel and alloc physical channel.
> While the issue_pending does not really alloc physical channel to
> support more request then physical channel.
> So when suspend we have to consider remove the channel from chan_pending.
> 
> When trying use virt-dma, have study drivers/dma/sa11x0-dma.c as good reference.
> 
> Sorry for my bad understanding.
No issues...

I think i am okay with else part looking at the driver again.

Can you resend by rebasing on my next and fxing any other issues

~Vinod
-- 
