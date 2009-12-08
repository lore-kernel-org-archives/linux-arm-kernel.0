From: joe@perches.com (Joe Perches)
Date: Tue, 08 Dec 2009 14:03:32 -0800
Subject: GPIO support for HTC Dream
In-Reply-To: <20091208214658.GC4164@elf.ucw.cz>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com> <20091208214658.GC4164@elf.ucw.cz>
Message-ID: <1260309812.27677.117.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-12-08 at 22:46 +0100, Pavel Machek wrote:
> Add GPIO support for HTC Dream.

Hi Pavel.  Thanks for this.

Maybe it'd be nicer to use pr_<level> and add
#define pr_fmt(fmt) KBUILD_MODNAME ":%s: " fmt, __func__
?

> +++ b/arch/arm/mach-msm/board-dream-gpio.c
> +static int dream_gpio_write(struct gpio_chip *chip, unsigned n, unsigned on)
[]
> +		printk(KERN_ERR "dream_gpio_write called on input %d\n", n);
		pr_err("called on input %d\n", n);
[]
> +static void dream_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
[]
> +			printk(KERN_ERR "dream_gpio_irq_handler: got masked "
			pr_err("got masked interrupt: %d:%02x\n"
> +++ b/arch/arm/mach-msm/generic_gpio.c
[]
> +int register_gpio_chip(struct gpio_chip *new_gpio_chip)
[]
> +		printk(KERN_ERR "register_gpio_chip: failed to allocate state\n");
		pr_err("failed to allocate state\n");
> +			printk(KERN_ERR "register_gpio_chip: failed to allocate array\n");
			pr_err("failed to allocate array\n");
[]
> +			printk(KERN_ERR "register_gpio_source %u-%u overlaps with %u-%u\n",
Wrong function name?
			pr_err("%u-%u overlaps with %u-%u\n",
