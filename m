From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Fri, 16 Aug 2013 11:02:20 -0400 (EDT)
Subject: [PATCH] gpio: (gpio-pca953x) move header to linux/platform_data/
In-Reply-To: <CACRpkdZdeVNtJSmc6Lr6j=oO9FLsAvjyrwhYS0j4OoAEhxCN9g@mail.gmail.com>
Message-ID: <82440653.410050.1376665340121.JavaMail.root@mail>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

You wrote:
> But:
> 
> >  drivers/gpio/gpio-pca953x.c                 |  2 +-
> (...)
> > diff --git a/drivers/gpio/gpio-pca953x.c
> > b/drivers/gpio/gpio-pca953x.c
> > index 426c51d..8804aec 100644
> > --- a/drivers/gpio/gpio-pca953x.c
> > +++ b/drivers/gpio/gpio-pca953x.c
> > @@ -18,7 +18,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/i2c.h>
> > -#include <linux/i2c/pca953x.h>
> > +#include <linux/platform_data/pca953x.h>
> 
> Why does the GPIO driver need platform data from the
> I2C driver???
> 
> Can't this just be made to go away?

I didn't dig that much in the driver, but I cannot imagine
another way to pass, for instance, the setup callback.

What would be a good alternative for you?

Regards,
Vivien
