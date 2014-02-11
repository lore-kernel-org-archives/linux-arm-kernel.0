From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Feb 2014 17:46:54 +0000
Subject: [PATCH 05/12] GPIO: gpio-generic: Add label to platform data
In-Reply-To: <1392139256.3380.45.camel@hornet>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-6-git-send-email-pawel.moll@arm.com>
 <20140211171721.GE15081@lee--X1> <1392139256.3380.45.camel@hornet>
Message-ID: <20140211174654.GI15081@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > When registering more than one platform device, it is
> > > useful to set the gpio chip label in the platform data.
> > >
> > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > Cc: Alexandre Courbot <gnurou@gmail.com>
> > > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > > ---
> > > This patch has been already merged by Linux; it has been included
> > > for completeness only.
> > >
> > >  drivers/gpio/gpio-generic.c     | 2 ++
> > >  include/linux/basic_mmio_gpio.h | 1 +
> > >  2 files changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
> > > index d2196bf..8c778af 100644
> > > --- a/drivers/gpio/gpio-generic.c
> > > +++ b/drivers/gpio/gpio-generic.c
> > > @@ -531,6 +531,8 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
> > >             return err;
> > >
> > >     if (pdata) {
> > > +           if (pdata->label)
> >
> > Why is this check necessary?
> >
> > > +                   bgc->gc.label = pdata->label;
> 
> Because bgc->gc.label is initialized to a default value in bgpio_init()
> and I don't want to override it with NULL if there is no label passed in
> the platform data.

Ah ha, thanks for clarifying.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
