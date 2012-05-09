From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Wed, 09 May 2012 14:32:45 +0530
Subject: [PATCH 2/6] dma: mxs-dma: let dma_is_apbh and apbh_is_old take
 parameter
In-Reply-To: <201205091100.34314.marex@denx.de>
References: <1336400595-12964-1-git-send-email-shawn.guo@linaro.org>
 <1336400595-12964-3-git-send-email-shawn.guo@linaro.org>
 <1336552827.1540.165.camel@vkoul-udesk3> <201205091100.34314.marex@denx.de>
Message-ID: <1336554165.1540.172.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-09 at 11:00 +0200, Marek Vasut wrote:
> Dear Vinod Koul,
> 
> > On Mon, 2012-05-07 at 22:23 +0800, Shawn Guo wrote:
> > > Let macros dma_is_apbh and apbh_is_old take mxs_dma as parameter
> > > to make the code easy to read.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > > 
> > >  drivers/dma/mxs-dma.c |   24 ++++++++++++------------
> > >  1 files changed, 12 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> > > index bd27818..e801fbf 100644
> > > --- a/drivers/dma/mxs-dma.c
> > > +++ b/drivers/dma/mxs-dma.c
> > > @@ -38,10 +38,10 @@
> > > 
> > >  #define MXS_DMA_APBH		0
> > >  #define MXS_DMA_APBX		1
> > > 
> > > -#define dma_is_apbh()		(mxs_dma->dev_id == MXS_DMA_APBH)
> > > +#define dma_is_apbh(mxs_dma)	(mxs_dma->dev_id == MXS_DMA_APBH)
> > > 
> > >  #define APBH_VERSION_LATEST	3
> > > 
> > > -#define apbh_is_old()		(mxs_dma->version < APBH_VERSION_LATEST)
> > > +#define apbh_is_old(mxs_dma)	(mxs_dma->version < APBH_VERSION_LATEST)
> > > 
> > >  #define HW_APBHX_CTRL0				0x000
> > >  #define BM_APBH_CTRL0_APB_BURST8_EN		(1 << 29)
> > > 
> > > @@ -54,10 +54,10 @@
> > > 
> > >  #define HW_APBH_VERSION				(cpu_is_mx23() ? 0x3f0 : 
> 0x800)
> > >  #define HW_APBX_VERSION				0x800
> > >  #define BP_APBHX_VERSION_MAJOR			24
> > > 
> > > -#define HW_APBHX_CHn_NXTCMDAR(n) \
> > > -	(((dma_is_apbh() && apbh_is_old()) ? 0x050 : 0x110) + (n) * 0x70)
> > > -#define HW_APBHX_CHn_SEMA(n) \
> > > -	(((dma_is_apbh() && apbh_is_old()) ? 0x080 : 0x140) + (n) * 0x70)
> > > +#define HW_APBHX_CHn_NXTCMDAR(d, n) \
> > > +	(((dma_is_apbh(d) && apbh_is_old(d)) ? 0x050 : 0x110) + (n) * 0x70)
> > > +#define HW_APBHX_CHn_SEMA(d, n) \
> > > +	(((dma_is_apbh(d) && apbh_is_old(d)) ? 0x080 : 0x140) + (n) * 0x70)
> > 
> > while at it, care to say what the above magic numbers mean. Isnt
> > terrible clear to me.
> 
> Check the email above ;-) I think simple comment would be enough here, but 
> defining those would not hurt either.
what does 050, 080... and other magic numbers here mean? Why is
everything getting multiplied by 0x70.


-- 
~Vinod
