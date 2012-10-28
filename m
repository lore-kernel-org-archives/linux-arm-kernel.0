From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 10:03:45 +0100
Subject: [PATCH 2/3] arm: bcm2835: convert to the irqchip infrastructure
In-Reply-To: <508C970F.9000305@wwwdotorg.org>
References: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351356317-16758-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <508C970F.9000305@wwwdotorg.org>
Message-ID: <20121028100345.32a58854@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Warren,

On Sat, 27 Oct 2012 20:23:11 -0600, Stephen Warren wrote:

> > On the arch/arm side, use irqchip_init() as the ->init_irq() callback,
> > and remove the definition of ->handle_irq() since this is now done by
> > the irq controller driver.
> 
> > diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
> 
> > +static void armctrl_handle_bank(int bank, struct pt_regs *regs)
> 
> To make the patch more readable, I'd suggest adding function prototypes
> at the start of the file, and not re-arranging the code. That'll remove
> the large cut/paste block in the diff. I wouldn't point out this trivial
> issue except that I think this needs a respin for the minor issue I
> raise below.

OK. I thought that forward declarations were completely forbidden in
the kernel coding style, but I don't mind changing the patch with this.

> > -static int __init armctrl_of_init(struct device_node *node,
> > -	struct device_node *parent)
> > +int __init armctrl_of_init(struct device_node *node,
> > +			   struct device_node *parent)
> 
> Since this is now a public API, it should probably be named better. How
> about bcm2835_irqchip_init()?

Well, it is public only within the boundaries of the irqchip
infrastructure, it doesn't get exposed beyond that. But I agree a
better name is good, so I'll change this.

> Aside from that,
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
