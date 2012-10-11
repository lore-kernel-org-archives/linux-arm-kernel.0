From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 11 Oct 2012 16:21:29 +0100
Subject: [PATCH 2/2] input: gpio-keys: Add runtime support
In-Reply-To: <CAM=Q2ctwTBAvKs401GgrGfz9NvaLspquje-6YfnuS5TZYeqY4Q@mail.gmail.com>
References: <1349964927-18619-1-git-send-email-lee.jones@linaro.org>
 <1349964927-18619-2-git-send-email-lee.jones@linaro.org>
 <CAM=Q2ctwTBAvKs401GgrGfz9NvaLspquje-6YfnuS5TZYeqY4Q@mail.gmail.com>
Message-ID: <20121011152129.GE15428@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > From: Jonas Aaberg <jonas.aberg@stericsson.com>
> Some change logs would have helped.

Granted.

Hopefully Jonas will be happy to step forward and answer any of
your following questions.

> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input at vger.kernel.org
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
> > Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
> > Reviewed-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
> > ---
> >  drivers/input/keyboard/gpio_keys.c |   16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> > index 7947315..78de557 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/pm_runtime.h>
> >
> >  struct gpio_button_data {
> >         const struct gpio_keys_button *button;
> > @@ -526,6 +527,7 @@ static int gpio_keys_open(struct input_dev *input)
> >  {
> >         struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
> >
> > +       pm_runtime_get_sync(input->dev.parent);
> I am not an expert of the runtime.
> 
> However would be grateful if you explain me what it actually do.
> 
> Also I did not see any runtime suspend/ resume handlers populated.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
