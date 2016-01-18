From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 18 Jan 2016 16:57:52 +0100
Subject: [RFC PATCH v2] irqchip: Add support for Tango interrupt controller
In-Reply-To: <569CE0F2.1060507@sigmadesigns.com>
References: <569CE0F2.1060507@sigmadesigns.com>
Message-ID: <569D0B80.1010908@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/2016 13:56, Marc Gonzalez wrote:

> For the arch/arm/mach-tango port, I'm using this driver written
> by Mans. Version 1 of the patch was submitted two months ago:
> http://thread.gmane.org/gmane.linux.kernel/2089471
> 
> I've tried to address Marc Zyngier's remarks.

And my patch is incomplete, v3 coming right up.

drivers/irqchip/irq-tango.c: In function 'tangox_irq_init':
drivers/irqchip/irq-tango.c:183:6: warning: unused variable 'i' [-Wunused-variable]
  int i;
      ^
drivers/irqchip/irq-tango.c: In function 'tangox_of_irq_init':
drivers/irqchip/irq-tango.c:200:6: warning: 'name' may be used uninitialized in this function [-Wmaybe-uninitialized]
  err = irq_alloc_domain_generic_chips(dom, 32, 2, name, handle_level_irq,
      ^
drivers/irqchip/irq-tango.c:179:14: note: 'name' was declared here
  const char *name;
              ^

Regards.
