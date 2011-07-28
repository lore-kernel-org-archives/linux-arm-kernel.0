From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Jul 2011 11:04:44 +0100
Subject: [PATCH 2/3] arch: arm: mach-cns3xxx: Add gpiolib support
In-Reply-To: <1311873401-26075-1-git-send-email-tommy.lin.1101@gmail.com>
References: <1311873401-26075-1-git-send-email-tommy.lin.1101@gmail.com>
Message-ID: <20110728100444.GC31473@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 01:16:41AM +0800, Tommy Lin wrote:
> +#include <linux/platform_device.h>
> +#include <linux/proc_fs.h>
> +#include <linux/io.h>
> +
> +#include <mach/gpio.h>

Come on guys, you absolutely deserve your code to break as you're
continuing to include mach/gpio.h directly, even after I've said
I'm going to be moving stuff out of mach/gpio.h into asm/gpio.h...

> +#include <asm-generic/gpio.h>
> +
> +#define gpio_get_value				__gpio_get_value
> +#define gpio_set_value				__gpio_set_value
> +#define gpio_cansleep				__gpio_cansleep
> +#define gpio_to_irq				__gpio_to_irq

Oh look, yet another identical implementation to add to the list...
(it's this stuff which I'm moving after this merge window.)

Please, make sure you include linux/gpio.h and not mach/gpio.h.
