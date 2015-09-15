From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 15 Sep 2015 14:04:49 +0200 (CEST)
Subject: [PATCH v3 2/8] genirq: irqdomain: Remove irqdomain dependency
 on struct device_node
In-Reply-To: <55F7F9E2.3070105@linaro.org>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
 <1442249047-21182-3-git-send-email-marc.zyngier@arm.com>
 <55F7F9E2.3070105@linaro.org>
Message-ID: <alpine.DEB.2.11.1509151401340.3971@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Sep 2015, Tomasz Nowicki wrote:

Can you folks please do proper quoting on reply? It's annoying to
scroll down 250+ lines to find TWO lines of reply and then have
another 250+ lines for nothing.

Here is the real gist of your reply:

> On 14.09.2015 18:44, Marc Zyngier wrote:
> > -struct irq_domain *__irq_domain_add(struct device_node *of_node, int size,
> > +struct irq_domain *__irq_domain_add(void *domain_token, int size,
> >   				    irq_hw_number_t hwirq_max, int direct_max,
> >   				    const struct irq_domain_ops *ops,
> >   				    void *host_data)
> >   {
> > +	struct device_node *of_node;
> >   	struct irq_domain *domain;
> > 
> > +	of_node = irq_domain_token_to_of_node(domain_token);
> >   	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
> >   			      GFP_KERNEL, of_node_to_nid(of_node));
> 
> While we are here, do you think it makes sense to abstract of_node_to_nid as
> well? Then we would really remove device_node dependency for irqdomain.

15 lines of useful content versus 500+ lines of useless noise.

Thanks,

	tglx
