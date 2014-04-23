From: alexanders83@web.de (Alexander Stein)
Date: Wed, 23 Apr 2014 07:57:56 +0200
Subject: [PATCH] pinctrl/at91: convert driver to use gpiolib irqchip
In-Reply-To: <CACRpkdYsPPRkht9+nTLHHQdzmej9sMpdFLqyy37YjEtYePB+mw@mail.gmail.com>
References: <1397592581-20251-1-git-send-email-alexanders83@web.de>
 <CACRpkdYsPPRkht9+nTLHHQdzmej9sMpdFLqyy37YjEtYePB+mw@mail.gmail.com>
Message-ID: <2125824.Uoi7hIqf8o@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014 23:39:38, Linus Walleij wrote:
> On Tue, Apr 15, 2014 at 10:09 PM, Alexander Stein <alexanders83@web.de> wrote:
> 
> > This converts the AT91 pin control driver to register its
> > chained irq handler and irqchip using the helpers in the
> > gpiolib core.
> >
> > Signed-off-by: Alexander Stein <alexanders83@web.de>
> 
> Part of the large attempt to pull all these local hacks into the
> gpiolib irqchip helpers so patch applied. Any further quarrels
> can be solved on top of this in the *generic* code.
> 
> I changed this:
> 
> > +static void gpio_orq_ack(struct irq_data *d)
> > +{
> > +       /* the interrupt is already cleared before by reading ISR */
> > +}
> > +
> >  static unsigned int gpio_irq_startup(struct irq_data *d)
> >  {
> >         struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
> > @@ -1434,6 +1420,7 @@ void at91_pinctrl_gpio_resume(void)
> >
> >  static struct irq_chip gpio_irqchip = {
> >         .name           = "GPIO",
> > +       .irq_ack        = gpio_orq_ack,
> 
> orq? I didn't get it so changed to irq when applying.

Yep, that was a typo. Thanks for noticing.

Regards,
Alexander
