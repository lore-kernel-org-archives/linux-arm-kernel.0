From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Mar 2013 22:00:39 +0900
Subject: [PATCH] ARM: S5PV210: Fix PL330 DMA controller clkdev entries
In-Reply-To: <51321326.6050800@gmail.com>
References: <1362227906-13921-1-git-send-email-s.nawrocki@samsung.com>
 <51321326.6050800@gmail.com>
Message-ID: <008001ce18d8$451527e0$cf3f77a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lonsn wrote:
> 
> ? 2013/3/2 20:38, Sylwester Nawrocki ??:
> > Since the DMA controller clocks are managed at amba bus level,
> > the PL330 device clocks handling has been removed from the driver
> > in commit 7c71b8eb268ee38235f7e924d943ea9d90e59469
> > DMA: PL330: Remove redundant runtime_suspend/resume functions
> >
> > However, this left the S5PV210 platform with only clkdev entries
> > linking "apb_pclk" clock conn_id to a dummy clock, rather than
> > to corresponding platform PL330 DMAC clock.
> > As a result the DMA controller is now attempted to be used on
> > S5PV210 with the clock disabled and the driver fails with an
> > error:
> >
> > dma-pl330 dma-pl330.0: PERIPH_ID 0x0, PCELL_ID 0x0 !
> > dma-pl330: probe of dma-pl330.0 failed with error -22
> > dma-pl330 dma-pl330.1: PERIPH_ID 0x0, PCELL_ID 0x0 !
> > dma-pl330: probe of dma-pl330.1 failed with error -22
> >
> > Fix this by adding "apb_pclk" clkdev entries for the Peripheral
> > DMA controllers 0/1 and removing the dummy apb_pclk clock.
> >
> > Reported-by: Lonsn <lonsn2005@gmail.com>
> > Cc: Inderpal Singh <inderpal.singh@linaro.org>
> > Cc: Boojin Kim <boojin.kim@samsung.com>
> > Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> > ---
> >
> > Lonsn, could you check if this patch solves the problem for you,
> > please ? Any Tested-by are welcome.
> > I didn't test this patch on any hardware yet. Once it is confirmed
> > I would resend it, also for stable kernels. It seems this issue is
> > present since v3.7.
> >
> Sylwester, I have tested this patch and confirmed it's OK in my S5PV210
> platform.
> 

Looks good to me, applied into -fixes.

Sylwester, why did you want to re-send this patch?

Thanks.

- Kukjin
