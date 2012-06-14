From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Thu, 14 Jun 2012 11:54:36 +0200
Subject: How to use linear mapping without DT?
Message-ID: <4FD9B4DC.80706@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

In fact, my question depends on sparse irq, irq domain and non DT.

I have enabled sparse_irq use for at91 sub architecture. I don't know if 
it is the good solution... I won't like to use n_irqs in my machine 
descriptor. I think the goal of sparse irq is to allocate the irq 
descriptor only when the irq is used. It's better than allocating the 
range that can be managed by the controller which should be indicated by 
nr_irqs.

In this case using the legacy irq domain is not the right solution since 
I will have to allocate the range of irq managed by the controller. 
Moving to linear irq domain should be better. Moreover, I have seen that 
Grant may want to remove it.

So, how to move to linear irq domain? In DT case, all the interrupts 
into the DT are mapped so the irq descriptor is allocated and my device 
will have the right virq number. In non DT case, my device has an irq 
number corresponding to a fixed value (which is in fact the hwirq 
number) but probably not to any existing virq.

So how to get a valid virq? Do I have to call irq_create_mapping from my 
driver? It's probably not the right way... Should I keep legacy domain 
and set nr_irqs?

Thanks

Regards

Ludovic
