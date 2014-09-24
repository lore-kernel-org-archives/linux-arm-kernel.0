From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 24 Sep 2014 11:13:12 +0100
Subject: [PATCH v2 0/8] initial suport for Alpscale ASM9260
In-Reply-To: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
Message-ID: <20140924101312.GB5729@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 21, 2014 at 07:41:36PM +0100, Oleksij Rempel wrote:
> This patchset provide initial support for Alpscale ASM9260,
> ARM based SoC.
> 
> Oleksij Rempel (8):
>   ARM: add mach-asm9260
>   add include/debug/asm9260.S
>   add alphascale,asm9260.h binding
>   ARM: dts: add DT for Alphascale ASM9260 SoC
>   clk: add clk-asm9260 driver
>   clocksource: add asm9260_timer driver
>   irqchip: add irq-asm9260 driver
>   tty/serial: add asm9260-serial driver

Several of these add new bindings, but no documentation (just a single
header).

Please document your device tree bindings.

Mark.

> 
>  arch/arm/Kconfig                                |   14 +
>  arch/arm/Kconfig.debug                          |   33 +-
>  arch/arm/Makefile                               |    1 +
>  arch/arm/boot/dts/Makefile                      |    2 +
>  arch/arm/boot/dts/alphascale-asm9260-devkit.dts |   15 +
>  arch/arm/boot/dts/alphascale-asm9260.dtsi       |  166 +++
>  arch/arm/include/debug/asm9260.S                |   31 +
>  arch/arm/mach-asm9260/Makefile                  |   11 +
>  arch/arm/mach-asm9260/Makefile.boot             |    2 +
>  arch/arm/mach-asm9260/core.c                    |   77 ++
>  drivers/clk/Makefile                            |    1 +
>  drivers/clk/clk-asm9260.c                       |  350 ++++++
>  drivers/clocksource/Makefile                    |    1 +
>  drivers/clocksource/asm9260_timer.c             |  244 ++++
>  drivers/irqchip/Makefile                        |    1 +
>  drivers/irqchip/irq-asm9260.c                   |  257 ++++
>  drivers/tty/serial/Kconfig                      |   17 +
>  drivers/tty/serial/Makefile                     |    1 +
>  drivers/tty/serial/asm9260_serial.c             | 1485 +++++++++++++++++++++++
>  include/dt-bindings/clock/alphascale,asm9260.h  |   97 ++
>  include/uapi/linux/serial_core.h                |    2 +
>  21 files changed, 2805 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
>  create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi
>  create mode 100644 arch/arm/include/debug/asm9260.S
>  create mode 100644 arch/arm/mach-asm9260/Makefile
>  create mode 100644 arch/arm/mach-asm9260/Makefile.boot
>  create mode 100644 arch/arm/mach-asm9260/core.c
>  create mode 100644 drivers/clk/clk-asm9260.c
>  create mode 100644 drivers/clocksource/asm9260_timer.c
>  create mode 100644 drivers/irqchip/irq-asm9260.c
>  create mode 100644 drivers/tty/serial/asm9260_serial.c
>  create mode 100644 include/dt-bindings/clock/alphascale,asm9260.h
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
