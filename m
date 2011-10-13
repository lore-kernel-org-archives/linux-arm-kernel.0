From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 10:54:42 +0100
Subject: [PATCH 8/9] ARM: SPMP8000: Add support for the Letcool board
In-Reply-To: <1318178172-7965-9-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-9-git-send-email-zoss@devai.org>
Message-ID: <20111013095442.GN21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 09, 2011 at 06:36:11PM +0200, Zoltan Devai wrote:
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm_backlight.h>
> +#include <linux/input.h>
> +#include <linux/basic_mmio_gpio.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <asm/hardware/vic.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach-types.h>
> +
> +#include <mach/core.h>
> +#include <mach/gpio.h>

In addition to Arnd's comments - please use linux/gpio.h rather than
mach/gpio.h or asm/gpio.h throughout your patches.  This helps to make
them future-proof.
