From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 03 Jan 2013 17:53:57 +1300
Subject: [PATCH 2/2] irqchip: vt8500: Move irq code to drivers/irqchip
In-Reply-To: <50E50B45.4040501@gmail.com>
References: <1357183510-8476-1-git-send-email-linux@prisktech.co.nz>
 <1357183510-8476-3-git-send-email-linux@prisktech.co.nz>
 <50E50B45.4040501@gmail.com>
Message-ID: <1357188837.9052.5.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-02 at 22:38 -0600, Rob Herring wrote:
> > CC: Thomas Gleixner <tglx@linutronix.de>
> >  arch/arm/mach-vt8500/Makefile |    2 +-
> >  arch/arm/mach-vt8500/common.h |    7 +-
> >  arch/arm/mach-vt8500/irq.c    |  253 -----------------------------------------
> >  drivers/irqchip/Makefile      |    1 +
> >  drivers/irqchip/irq-vt8500.c  |  253 +++++++++++++++++++++++++++++++++++++++++
> 
> It's easy to forget, but please post using the -M option so only real
> changes are shown.

Ok.

> > -/* defined in irq.c */
> > +/* defined in drivers/irqchip/irq.c */
> > +int __init vt8500_irq_init(struct device_node *node,
> > +				struct device_node *parent);
> >  asmlinkage void vt8500_handle_irq(struct pt_regs *regs);
> 
> These should go away with irqchip infrastructure Thomas and I have been
> working on. I plan to post updated version in the next day.
> 
> Rob

Do you want me to rebase this patch on the new infrastructure once it's
in a tree somewhere, or was this a heads-up that it will need another
patch at some point?

I only ask because if these patches need to be separated it will created
merge-conflicts with arm-soc later on.

Regards
Tony P
