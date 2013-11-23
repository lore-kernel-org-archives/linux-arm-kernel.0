From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Nov 2013 00:55:09 +0000
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131123004334.GJ10023@atomide.com>
References: <20131123004334.GJ10023@atomide.com>
Message-ID: <20131123005509.GJ16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 04:43:35PM -0800, Tony Lindgren wrote:
> +		/* See of_device_resource_notify for populating interrupts */
> +		for (i = 0; i < num_irq; i++, res++) {
> +			res->flags = IORESOURCE_IRQ;
> +			res->start = -EPROBE_DEFER;
> +			res->end = -EPROBE_DEFER;

NAK.  Definitely a bad idea to start introducing magic values other into
resources.  Please don't do this.
