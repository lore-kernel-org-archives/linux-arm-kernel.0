From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 11 Apr 2012 12:09:22 +0000
Subject: [PATCHv7 14/18] I2C: OMAP: Use SET_RUNTIME_PM_OPS
In-Reply-To: <20120411113537.GG12064@arwen.pp.htv.fi>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-15-git-send-email-shubhrajyoti@ti.com>
 <20120411113537.GG12064@arwen.pp.htv.fi>
Message-ID: <1BAFE6F6C881BF42822005164F1491C331829571@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bablpi,

On Wed, Apr 11, 2012 at 17:05:38, Balbi, Felipe wrote:
> On Wed, Apr 11, 2012 at 04:42:52PM +0530, Shubhrajyoti D wrote:
> > Use SET_RUNTIME_PM_OPS macro to set runtime functions.
> > 
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > ---
> >  drivers/i2c/busses/i2c-omap.c |   11 ++++-------
> >  1 files changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > index dd65416..28de1d2 100644
> > --- a/drivers/i2c/busses/i2c-omap.c
> > +++ b/drivers/i2c/busses/i2c-omap.c
> > @@ -1217,15 +1217,12 @@ static int omap_i2c_runtime_resume(struct device *dev)
> >  
> >  	return 0;
> >  }
> > +#endif
> >  
> >  static struct dev_pm_ops omap_i2c_pm_ops = {
> > -	.runtime_suspend = omap_i2c_runtime_suspend,
> > -	.runtime_resume = omap_i2c_runtime_resume,
> > +	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,
> > +			   omap_i2c_runtime_resume, NULL)
> >  };
> > -#define OMAP_I2C_PM_OPS (&omap_i2c_pm_ops)
> > -#else
> > -#define OMAP_I2C_PM_OPS NULL
> > -#endif
> 
> I think you should keep this define, otherwise the pm pointer will
> always be valid.

No. using SET_RUNTIME_PM_OPS will make it NULL when !CONFIG_PM_RUNTIME
Kindly correct me if I am wrong.

> 
> -- 
> balbi
> 


Regards, 
Gururaja
