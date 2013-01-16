From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 16 Jan 2013 12:45:28 +0000
Subject: [PATCH 3/4] pinctrl: add abx500 pinctrl driver core
In-Reply-To: <50F5A1B7.20504@wwwdotorg.org>
References: <1358242984-5160-1-git-send-email-linus.walleij@stericsson.com>
 <50F5A1B7.20504@wwwdotorg.org>
Message-ID: <20130116124528.GD20091@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +static int abx500_gpio_irq_init(struct abx500_pinctrl *pct)
> ...
> > +#ifdef CONFIG_ARM
> > +		set_irq_flags(irq, IRQF_VALID);
> > +#else
> > +		irq_set_noprobe(irq);
> > +#endif
> 
> I assume that ifdef is always set one particular way?
> 
> > +static void abx500_gpio_irq_remove(struct abx500_pinctrl *pct)
> ...
> > +#ifdef CONFIG_ARM
> > +		set_irq_flags(irq, 0);
> > +#endif
> 
> Same there.

You can safely ignore anything to do with IRQs in this patch-set, as
I have a follow-up one (originally written for the old gpio-ab8500
driver - which this is the successor to), which pulls it all out and
applies to the ab8500-core driver instead.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
