From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 May 2015 13:33:14 +0100
Subject: [PATCH v3 01/17] mfd: add new driver for Sharp LoCoMo
In-Reply-To: <20150519112134.GD2067@n2100.arm.linux.org.uk>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
 <1431880077-26321-2-git-send-email-dbaryshkov@gmail.com>
 <20150519103828.GU22418@x1>
 <20150519112134.GD2067@n2100.arm.linux.org.uk>
Message-ID: <20150519123314.GA3627@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 May 2015, Russell King - ARM Linux wrote:

> On Tue, May 19, 2015 at 11:38:28AM +0100, Lee Jones wrote:
> > On Sun, 17 May 2015, Dmitry Eremin-Solenikov wrote:
> > > +static void locomo_mask_irq(struct irq_data *d)
> > > +{
> > > +	struct locomo *ldev = irq_data_get_irq_chip_data(d);
> > > +	unsigned int mask = 0x0010 << d->hwirq;
> > 
> > This also needs defining.
> > 
> > Why not
> >   BIT(d->hwirq + 1)
> 
> I think your maths is off...
> 
> 0x0010 << d->hwirq != BIT(d->hwirq + 1)

Ah, that's hex.  I was blinded by the 1's and 0's.  Doh!

Thanks Russell.

---

Why not
  BIT(d->hwirq + 4)

... with an explanation as to why you're skipping the first 4 bits?

/me hopes that maths is right now. :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
