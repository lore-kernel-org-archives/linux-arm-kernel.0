From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Jun 2015 10:10:27 +0100
Subject: [REBASED 2/5] regulator: pwm-regulator: Separate voltage-table
 initialisation
In-Reply-To: <20150610110206.6194cc0f@ipc1.ka-ro>
References: <1433923073-907-1-git-send-email-lee.jones@linaro.org>
 <1433923073-907-3-git-send-email-lee.jones@linaro.org>
 <20150610110206.6194cc0f@ipc1.ka-ro>
Message-ID: <20150610091027.GB2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oh my ...

On Wed, 10 Jun 2015, Lothar Wa?mann wrote:
> > Take this out of the main .probe() routine in order to facilitate the
> > introduction of different ways to obtain 'duty cycle' information.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/mfd-child.c           | 47 ++++++++++++++++++++++++
> >  drivers/regulator/pwm-regulator.c | 77 +++++++++++++++++++++++----------------
> >  2 files changed, 92 insertions(+), 32 deletions(-)
> >  create mode 100644 drivers/mfd/mfd-child.c
> > 
> > diff --git a/drivers/mfd/mfd-child.c b/drivers/mfd/mfd-child.c
> > new file mode 100644
> > index 0000000..f233add
> > --- /dev/null
> > +++ b/drivers/mfd/mfd-child.c
> > @@ -0,0 +1,47 @@
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> > +
> > +static int simple_mfd_child_probe(struct platform_device *pdev)
> > +{
> > +	struct resource *res;
> > +	void __iomem *base;
> > +	int irq;
> > +
> > +	printk("LEE: %s %s()[%d]: Enter\n", __FILE__, __func__, __LINE__);
> > +
> Debugging remnant?
> 
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	dev_err(&pdev->dev, "Phys: %x: %x\n", res->start, resource_size(res));
> > +
> That's not an error message and thus shouldn't be printed with
> dev_err(). dev_dbg() would be more appropriate here.

This entire file is cruft and has nothing to do with this set.

It was knocked it up quickly to test something unrelated.

I will resubmit this patch with it removed.

Sorry for the noise.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
