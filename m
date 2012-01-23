From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Jan 2012 11:36:48 +0000
Subject: [PATCH 1/1] ARM: Developed device driver for Atmel TSADC
 controller
In-Reply-To: <1327317907-2874-1-git-send-email-pettno@gmail.com>
References: <n> <1327317907-2874-1-git-send-email-pettno@gmail.com>
Message-ID: <20120123113647.GX1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 12:25:06PM +0100, Petter Nordby wrote:
> Some Atmel AT91 devices contains a touchscreen analog to digital
> converter. This device driver use the ADC as a multi-channel raw
> data input device.
> 
> Tested on AT91SAM9G45 boards.
> 
> Signed-off-by: Petter Nordby <pettno@gmail.com>
> ---
>  CREDITS                                    |    4 +

Shouldn't this be in MAINTAINERS?

>  arch/arm/configs/at91sam9g45_defconfig     |    1 +
>  arch/arm/mach-at91/include/mach/at91_adc.h |   16 ++
>  drivers/misc/Kconfig                       |    7 +
>  drivers/misc/Makefile                      |    1 +
>  drivers/misc/atmel_tsadc.c                 |  361 ++++++++++++++++++++++++++++

We have a proper abstraction of input devices under drivers/input which
includes touchscreens.  I suggest using that rather than developing
your own private kernel API.

It will avoid all sorts of bugs, like using put_user() with IRQs disabled.

Thanks.
