From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 8 Nov 2013 09:20:25 +0000
Subject: mfd: ab8500-debug: Add wake-up info
In-Reply-To: <20131107134326.GO20521@mwanda>
References: <20130826150908.GB12428@elgon.mountain>
 <20131107134326.GO20521@mwanda>
Message-ID: <20131108092025.GS30901@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> What ever happened to this?  Can "desc" be NULL or not?

You'll be lucky to get a response. ST-Ericsson are quite dead.

However, from my investigation it appears desc 'can' be NULL.

> On Mon, Aug 26, 2013 at 06:09:08PM +0300, Dan Carpenter wrote:
> > Hello Jonas Aaberg,
> > 
> > This is a semi-automatic email about new static checker warnings.
> > 
> > The patch 2cf64e264828: "mfd: ab8500-debug: Add wake-up info" from 
> > May 31, 2012, leads to the following Smatch complaint:
> > 
> > drivers/mfd/ab8500-debugfs.c:1609 ab8500_interrupts_print()
> > 	 warn: variable dereferenced before check 'desc' (see line 1603)
> > 
> > drivers/mfd/ab8500-debugfs.c
> >   1602			struct irq_desc *desc = irq_to_desc(line + irq_first);
> >   1603			struct irqaction *action = desc->action;
> >                                                    ^^^^^^^^^^^^
> > Patch adds dereference.
> > 
> >   1604	
> >   1605			seq_printf(s, "%3i:  %6i %4i", line,
> >   1606				   num_interrupts[line],
> >   1607				   num_wake_interrupts[line]);
> >   1608	
> >   1609			if (desc && desc->name)
> >                             ^^^^
> > Patch adds check.
> > 
> >   1610				seq_printf(s, "-%-8s", desc->name);
> >   1611			if (action) {
> > 
> > regards,
> > dan carpenter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
