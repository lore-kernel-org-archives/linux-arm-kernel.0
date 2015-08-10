From: HenryC.Chen@mediatek.com (Henry Chen)
Date: Mon, 10 Aug 2015 20:23:21 +0800
Subject: [PATCH] mfd: mt6397: Implement wake handler and suspend/resume
 for mt6397-core.c
In-Reply-To: <20150810114224.GD3249@x1>
References: <1438268846-22451-1-git-send-email-henryc.chen@mediatek.com>
 <20150810114224.GD3249@x1>
Message-ID: <1439209401.32674.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jones,

On Mon, 2015-08-10 at 12:42 +0100, Lee Jones wrote:
> No need to mention the filename in the subject line.  You already
> mentioned which driver is effected by the change.
Ok, it will be changed.

> 
> > Register mt6393_irq as wake up source to pinctrl by flag "IRQF_NO_SUSPEND".
> > Implement .irq_set_wake() function of pmic to keep who is wakeup source,
> > and enable irq on .suspend()and restore irq on .resume().
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  drivers/mfd/mt6397-core.c       | 49 ++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/mfd/mt6397/core.h |  1 +
> >  2 files changed, 49 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > index 03929a6..aebdee5 100644
> > --- a/drivers/mfd/mt6397-core.c
> > +++ b/drivers/mfd/mt6397-core.c
> 
> [...]
> 
> > @@ -142,6 +161,7 @@ static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
> >  	irq_set_chip_data(irq, mt6397);
> >  	irq_set_chip_and_handler(irq, &mt6397_irq_chip, handle_level_irq);
> >  	irq_set_nested_thread(irq, 1);
> > +
> 
> Remainder of the patch looks okay, but this irrelevant change, which
> has nothing to do with the remainder of the patch will cause issues if
> I attempt to apply it.  Please remove and re-submit.
> 
Sorry, I will remove it, thanks.
Henry

> [...]
> 
