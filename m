From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jul 2011 11:06:48 +0100
Subject: [PATCH 3/3] arch: arm: mach-cns3xxx: Add external interrupt
	pin demo program
In-Reply-To: <1311873475-26111-1-git-send-email-tommy.lin.1101@gmail.com>
References: <1311873475-26111-1-git-send-email-tommy.lin.1101@gmail.com>
Message-ID: <20110728100648.GD31473@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 01:17:55AM +0800, Tommy Lin wrote:
> +#include <mach/gpio.h>

Need I mention it...
> +static irqreturn_t cns3xxx_ext_intr1_handler(int irq, void *dev_id)
> +{
> +	int value;
> +
> +	value = gpio_get_value(led_D6);
> +
> +	disable_irq_nosync(irq);
> +
> +	gpio_set_value(led_D6, !value);
> +
> +	enable_irq(irq);

Why do you need the disable_irq/enable_irq ?  The interrupt you're
dealing with will already be masked by the core genirq code.
