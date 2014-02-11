From: Pawel.Moll@arm.com (Pawel Moll)
Date: Tue, 11 Feb 2014 17:20:56 +0000
Subject: [PATCH 05/12] GPIO: gpio-generic: Add label to platform data
In-Reply-To: <20140211171721.GE15081@lee--X1>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-6-git-send-email-pawel.moll@arm.com>
 <20140211171721.GE15081@lee--X1>
Message-ID: <1392139256.3380.45.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-11 at 17:17 +0000, Lee Jones wrote:
> > When registering more than one platform device, it is
> > useful to set the gpio chip label in the platform data.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Alexandre Courbot <gnurou@gmail.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> > This patch has been already merged by Linux; it has been included
> > for completeness only.
> >
> >  drivers/gpio/gpio-generic.c     | 2 ++
> >  include/linux/basic_mmio_gpio.h | 1 +
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
> > index d2196bf..8c778af 100644
> > --- a/drivers/gpio/gpio-generic.c
> > +++ b/drivers/gpio/gpio-generic.c
> > @@ -531,6 +531,8 @@ static int bgpio_pdev_probe(struct platform_device *pdev)
> >             return err;
> >
> >     if (pdata) {
> > +           if (pdata->label)
>
> Why is this check necessary?
>
> > +                   bgc->gc.label = pdata->label;

Because bgc->gc.label is initialized to a default value in bgpio_init()
and I don't want to override it with NULL if there is no label passed in
the platform data.

Pawel

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
