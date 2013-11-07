From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 7 Nov 2013 16:43:26 +0300
Subject: mfd: ab8500-debug: Add wake-up info
In-Reply-To: <20130826150908.GB12428@elgon.mountain>
References: <20130826150908.GB12428@elgon.mountain>
Message-ID: <20131107134326.GO20521@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What ever happened to this?  Can "desc" be NULL or not?

regards,
dan carpenter

On Mon, Aug 26, 2013 at 06:09:08PM +0300, Dan Carpenter wrote:
> Hello Jonas Aaberg,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 2cf64e264828: "mfd: ab8500-debug: Add wake-up info" from 
> May 31, 2012, leads to the following Smatch complaint:
> 
> drivers/mfd/ab8500-debugfs.c:1609 ab8500_interrupts_print()
> 	 warn: variable dereferenced before check 'desc' (see line 1603)
> 
> drivers/mfd/ab8500-debugfs.c
>   1602			struct irq_desc *desc = irq_to_desc(line + irq_first);
>   1603			struct irqaction *action = desc->action;
>                                                    ^^^^^^^^^^^^
> Patch adds dereference.
> 
>   1604	
>   1605			seq_printf(s, "%3i:  %6i %4i", line,
>   1606				   num_interrupts[line],
>   1607				   num_wake_interrupts[line]);
>   1608	
>   1609			if (desc && desc->name)
>                             ^^^^
> Patch adds check.
> 
>   1610				seq_printf(s, "-%-8s", desc->name);
>   1611			if (action) {
> 
> regards,
> dan carpenter
