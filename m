From: yt.shen@mediatek.com (YT Shen)
Date: Wed, 1 Jun 2016 17:09:05 +0800
Subject: [RFC v2 1/5] drm/mediatek: rename macros, add chip suffix
In-Reply-To: <20160530104129.GA8388@ulmo.ba.sec>
References: <1463756736-46573-1-git-send-email-yt.shen@mediatek.com>
 <1463756736-46573-2-git-send-email-yt.shen@mediatek.com>
 <20160530104129.GA8388@ulmo.ba.sec>
Message-ID: <1464772145.10410.27.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Mon, 2016-05-30 at 12:41 +0200, Thierry Reding wrote:
> On Fri, May 20, 2016 at 11:05:32PM +0800, yt.shen at mediatek.com wrote:
> > From: YT Shen <yt.shen@mediatek.com>
> > 
> > Add MT8173 suffix for hardware related macros.
> > 
> > Signed-off-by: YT Shen <yt.shen@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c |   62 ++++++++++++++++----------------
> >  1 file changed, 31 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index 17ba935..d6aafd4 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -36,21 +36,21 @@
> >  #define DISP_REG_MUTEX_MOD(n)	(0x2c + 0x20 * (n))
> >  #define DISP_REG_MUTEX_SOF(n)	(0x30 + 0x20 * (n))
> >  
> > -#define MUTEX_MOD_DISP_OVL0		BIT(11)
> > -#define MUTEX_MOD_DISP_OVL1		BIT(12)
> > -#define MUTEX_MOD_DISP_RDMA0		BIT(13)
> > -#define MUTEX_MOD_DISP_RDMA1		BIT(14)
> > -#define MUTEX_MOD_DISP_RDMA2		BIT(15)
> > -#define MUTEX_MOD_DISP_WDMA0		BIT(16)
> > -#define MUTEX_MOD_DISP_WDMA1		BIT(17)
> > -#define MUTEX_MOD_DISP_COLOR0		BIT(18)
> > -#define MUTEX_MOD_DISP_COLOR1		BIT(19)
> > -#define MUTEX_MOD_DISP_AAL		BIT(20)
> > -#define MUTEX_MOD_DISP_GAMMA		BIT(21)
> > -#define MUTEX_MOD_DISP_UFOE		BIT(22)
> > -#define MUTEX_MOD_DISP_PWM0		BIT(23)
> > -#define MUTEX_MOD_DISP_PWM1		BIT(24)
> > -#define MUTEX_MOD_DISP_OD		BIT(25)
> > +#define MUTEX_MOD_DISP_OVL0_MT8173		BIT(11)
> > +#define MUTEX_MOD_DISP_OVL1_MT8173		BIT(12)
> > +#define MUTEX_MOD_DISP_RDMA0_MT8173		BIT(13)
> > +#define MUTEX_MOD_DISP_RDMA1_MT8173		BIT(14)
> > +#define MUTEX_MOD_DISP_RDMA2_MT8173		BIT(15)
> > +#define MUTEX_MOD_DISP_WDMA0_MT8173		BIT(16)
> > +#define MUTEX_MOD_DISP_WDMA1_MT8173		BIT(17)
> > +#define MUTEX_MOD_DISP_COLOR0_MT8173		BIT(18)
> > +#define MUTEX_MOD_DISP_COLOR1_MT8173		BIT(19)
> > +#define MUTEX_MOD_DISP_AAL_MT8173		BIT(20)
> > +#define MUTEX_MOD_DISP_GAMMA_MT8173		BIT(21)
> > +#define MUTEX_MOD_DISP_UFOE_MT8173		BIT(22)
> > +#define MUTEX_MOD_DISP_PWM0_MT8173		BIT(23)
> > +#define MUTEX_MOD_DISP_PWM1_MT8173		BIT(24)
> > +#define MUTEX_MOD_DISP_OD_MT8173		BIT(25)
> 
> Just a random fly-by comment: this looks like a hardware spinlock, have
> you ever considered implementing this as a hwspinlock driver? See the
> drivers/hwspinlock subdirectory for existing examples.
> 
> Thierry

I see the drivers/hwspinlock and Documentation/hwspinlock.txt
Yes, we can implement this like a hardware spinlock.  But I have some
questions, the document says:

"Hardware spinlock modules provide hardware assistance for
synchronization and mutual exclusion between heterogeneous processors
and those not operating under a single, shared operating system"

The mutex here is a handshake interface between software and hardware.
The hardware is the display controller, the software is the drm display
driver, and no other consumers need to access this mutex.  So I think
that using hwspinlock to implement a bit too complicated, am I right?

I will use iopoll macros to implement this part in the next version.
Thanks.

yt.shen
