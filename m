From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 20 Jan 2015 14:01:43 +0000
Subject: [PATCH 6/7] mfd: menelaus: make vcore and regulator controls
 internal
In-Reply-To: <20150120135840.GO13701@x1>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-7-git-send-email-aaro.koskinen@iki.fi>
 <20150120135840.GO13701@x1>
Message-ID: <20150120140143.GQ13701@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Jan 2015, Lee Jones wrote:

> On Sat, 27 Dec 2014, Aaro Koskinen wrote:
> 
> > Make vcore and regulator control functions internal to the driver.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> >  drivers/mfd/menelaus.c       | 13 +++++++++++--
> >  include/linux/mfd/menelaus.h | 12 ------------
> >  2 files changed, 11 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
> > index 4a900cc..8660adf 100644
> > --- a/drivers/mfd/menelaus.c
> > +++ b/drivers/mfd/menelaus.c
> > @@ -163,6 +163,15 @@
> >  #define MCT_PIN_ST_S1_CD_ST		(1 << 0)
> >  #define MCT_PIN_ST_S2_CD_ST		(1 << 1)
> >  
> > +#define EN_VPLL_SLEEP			(1 << 7)
> > +#define EN_VMMC_SLEEP			(1 << 6)
> > +#define EN_VAUX_SLEEP			(1 << 5)
> > +#define EN_VIO_SLEEP			(1 << 4)
> > +#define EN_VMEM_SLEEP			(1 << 3)
> > +#define EN_DC3_SLEEP			(1 << 2)
> > +#define EN_DC2_SLEEP			(1 << 1)
> > +#define EN_VC_SLEEP			(1 << 0)
> 
> Better to use the BIT() macro for this kind of stuff.
> 
> Please take this opportunity to use it.

In fact, nevermind.  I'll do it from here.

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
