From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 21 Oct 2010 15:26:04 -0700
Subject: [PATCH v3 00/12] tnetv107x ssp driver stack
In-Reply-To: <1287694873-12904-1-git-send-email-cyril@ti.com> (Cyril
	Chemparathy's message of "Thu, 21 Oct 2010 17:01:01 -0400")
References: <1287694873-12904-1-git-send-email-cyril@ti.com>
Message-ID: <87mxq7p4hv.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cyril Chemparathy <cyril@ti.com> writes:

> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> device.  It has a built-in programmable execution engine that can be programmed
> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).

Andrew, looking for some advice here...

This is a piece of davinci hardware, but introduces drivers in various
subsystems.  I'm willing to merge this series via the davinci tree after
getting acks from the various subsystem maintainers.  Is this an OK
approach?  It seems best to me to merge this all together.

We already have acks for the regulator and gpio driver parts, and the
backlight driver has a clear owner in MAINTAINERS.  However, who should
be doing the final review/ack of the drivers/misc and drivers/gpio
changes is less clear to me.  

Any advice appreciated,

Thanks,

Kevin

>  arch/arm/mach-davinci/board-tnetv107x-evm.c    |  199 +++++++
>  arch/arm/mach-davinci/devices-tnetv107x.c      |   25 +
>  arch/arm/mach-davinci/include/mach/ti_ssp.h    |   98 ++++
>  arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +
>  arch/arm/mach-davinci/tnetv107x.c              |    2 +-
>  drivers/gpio/Kconfig                           |   10 +
>  drivers/gpio/Makefile                          |    1 +
>  drivers/gpio/ti-ssp-gpio.c                     |  200 +++++++
>  drivers/misc/Kconfig                           |   11 +
>  drivers/misc/Makefile                          |    1 +
>  drivers/misc/ti_ssp.c                          |  436 +++++++++++++++
>  drivers/regulator/Kconfig                      |   10 +
>  drivers/regulator/Makefile                     |    1 +
>  drivers/regulator/tps6524x-regulator.c         |  692 ++++++++++++++++++++++++
>  drivers/spi/Kconfig                            |    7 +
>  drivers/spi/Makefile                           |    1 +
>  drivers/spi/spi_ti_ssp.c                       |  397 ++++++++++++++
>  drivers/video/backlight/Kconfig                |    7 +
>  drivers/video/backlight/Makefile               |    2 +-
>  drivers/video/backlight/tps6116x.c             |  340 ++++++++++++
