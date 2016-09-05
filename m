From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 5 Sep 2016 09:47:27 +0200
Subject: [PATCH v3 2/9] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <alpine.DEB.2.20.1609022052470.5647@nanos>
References: <1472830398-13275-1-git-send-email-alexandre.torgue@st.com>
 <1472830398-13275-3-git-send-email-alexandre.torgue@st.com>
 <alpine.DEB.2.20.1609022052470.5647@nanos>
Message-ID: <d790a3fd-766a-36d3-7a05-40b3198777c6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 09/02/2016 08:57 PM, Thomas Gleixner wrote:
> Alexandre,
>
> On Fri, 2 Sep 2016, Alexandre TORGUE wrote:
>
> This all looks very reasonable. The only complaint I have is your variable
> declaration ordering or the lack thereof.
>
> 1)
>> +	struct irq_domain *domain = irq_desc_get_handler_data(desc);
>> +	struct irq_chip_generic *gc = domain->gc->gc[0];
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	unsigned long pending;
>> +	int n;
>
> 2)
>> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
>> +	u32 rtsr, ftsr;
>> +	int pin = data->hwirq;
>
> 3)
>> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
>> +	int pin = data->hwirq;
>> +	u32 emr;
>
> 4)
>> +	irq_hw_number_t hwirq;
>> +	struct irq_fwspec *fwspec = data;
>> +	struct irq_chip_generic *gc = d->gc->gc[0];
>
> 5)
>> +	int nr_irqs, nr_exti, ret, i;
>> +	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
>> +	struct irq_domain *domain;
>> +	struct irq_chip_generic *gc;
>> +	void *base;
>
> #1 and 3 have the ordering which is preferred in the irq code.
>
> #2, #4 and #5 are three permutations which are way harder to read.
>
>> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
>> +	int pin = data->hwirq;
>> +	u32 rtsr, ftsr;
>
>> +	struct irq_chip_generic *gc = d->gc->gc[0];
>> +	struct irq_fwspec *fwspec = data;
>> +	irq_hw_number_t hwirq;
>
>> +	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
>> +	int nr_irqs, nr_exti, ret, i;
>> +	struct irq_chip_generic *gc;
>> +	struct irq_domain *domain;
>> +	void *base;
>
> Can you spot the difference?

Thanks for review and for proposal. It Will be in next version.

Regards

Alex

>
> Thanks,
>
> 	tglx
>
