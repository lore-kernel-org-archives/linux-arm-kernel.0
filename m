From: martin@kaiser.cx (Martin Kaiser)
Date: Tue, 27 Feb 2018 22:25:17 +0100
Subject: [PATCH RFC] ARM: imx: avic: set low-power interrupt mask for imx25
In-Reply-To: <20180224073408.GE3217@dragon>
References: <1518180203-9698-1-git-send-email-martin@kaiser.cx>
 <20180224073408.GE3217@dragon>
Message-ID: <20180227212517.GA5227@botnar.kaiser.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn and all,

Thus wrote Shawn Guo (shawnguo at kernel.org):

> > +static void __iomem *avic_base, *mx25_ccm_base;

> Keep avic_base line untouched, and add a new one for mx25_ccm_base.

ok

> >  static struct irq_domain *domain;

> >  #ifdef CONFIG_FIQ
> > @@ -93,6 +97,11 @@ static void avic_irq_suspend(struct irq_data *d)

> >  	avic_saved_mask_reg[idx] = imx_readl(avic_base + ct->regs.mask);
> >  	imx_writel(gc->wake_active, avic_base + ct->regs.mask);

> Have a newline here.

ok

> >  static void avic_irq_resume(struct irq_data *d)
> > @@ -102,6 +111,11 @@ static void avic_irq_resume(struct irq_data *d)
> >  	int idx = d->hwirq >> 5;

> >  	imx_writel(avic_saved_mask_reg[idx], avic_base + ct->regs.mask);

> Ditto

ok

Please note that, as there were no fundamental doubts about my approach,
I submitted a "regular patch" based on this RFC patch a couple of days
later.

I'll update this regular patch and submit a v2.

Best regards,

   Martin
