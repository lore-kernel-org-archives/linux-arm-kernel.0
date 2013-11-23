From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Nov 2013 17:08:51 -0800
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131123005509.GJ16735@n2100.arm.linux.org.uk>
References: <20131123004334.GJ10023@atomide.com>
 <20131123005509.GJ16735@n2100.arm.linux.org.uk>
Message-ID: <20131123010850.GN10023@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [131122 16:56]:
> On Fri, Nov 22, 2013 at 04:43:35PM -0800, Tony Lindgren wrote:
> > +		/* See of_device_resource_notify for populating interrupts */
> > +		for (i = 0; i < num_irq; i++, res++) {
> > +			res->flags = IORESOURCE_IRQ;
> > +			res->start = -EPROBE_DEFER;
> > +			res->end = -EPROBE_DEFER;
> 
> NAK.  Definitely a bad idea to start introducing magic values other into
> resources.  Please don't do this.

Do you have any better ideas on how to sort out this issue then?

Tony
