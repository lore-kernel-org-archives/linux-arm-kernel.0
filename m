From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Oct 2010 14:32:59 +0200
Subject: [PATCH] Acme Systems FOX Board G20 board files
In-Reply-To: <1287014786-25543-1-git-send-email-tanzilli@acmesystems.it>
References: <1287014786-25543-1-git-send-email-tanzilli@acmesystems.it>
Message-ID: <20101015123259.GH11127@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> @@ -0,0 +1,279 @@
> +/*
> + *  Copyright (C) 2005 SAN People
> + *  Copyright (C) 2008 Atmel
> + *  Copyright (C) 2010 Lee McLoughlin - lee at lmmrtech.com
> + *  Copyright (C) 2010 Sergio Tanzilli - tanzilli at acmesystems.it
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/types.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/at73c213.h>
> +#include <linux/gpio_keys.h>
> +#include <linux/input.h>
> +#include <linux/clk.h>
> +#include <linux/w1-gpio.h>
> +
> +#include <mach/hardware.h>
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/irq.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/irq.h>
> +
> +#include <mach/board.h>
> +#include <mach/gpio.h>
please replace by linux/gpio.h
> +#include <mach/at91sam9_smc.h>
> +
> +#include "sam9_smc.h"
> +#include "generic.h"
> +
> +/*
> + * The FOX Board G20 hardware comes as the "Netus G20" board with
> + * just the cpu, ram, dataflash and two header connectors.
> + * This is plugged into the FOX Board which provides the ethernet,
> + * usb, rtc, leds, switch, ...
> + *
> + * For more info visit: http://www.acmesystems.it/foxg20
> + */
> +
> +
> +	.is_rmii	= 1,
> +};
please not 4 blank line
> +
> +
> +
> +
> +/*
> + * MCI (SD/MMC)
> + * det_pin, wp_pin and vcc_pin are not connected
> + */
> +static struct at91_mmc_data __initdata foxg20_mmc_data = {
> +	.slot_b		= 1,
> +	.wire4		= 1,
> +};
> +
> +
> +/*
> + * LEDs
> + */
> +static struct gpio_led foxg20_leds[] = {
> +	{	/* user led, red */
> +		.name			= "user_led",
> +		.gpio			= AT91_PIN_PC7,
> +		.active_low		= 0,
> +		.default_trigger	= "heartbeat",
> +	},
> +};
> +
> +

please also fix some white spaces

use checkpatch.pl


Best Regards,
J.
