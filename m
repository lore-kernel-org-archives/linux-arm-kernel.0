From: linux@rempel-privat.de (Oleksij Rempel)
Date: Fri, 10 Oct 2014 07:38:40 +0200
Subject: [PATCH v3 0/9] initial suport for Alphascale ASM9260
In-Reply-To: <1412672123-16694-1-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1412672123-16694-1-git-send-email-linux@rempel-privat.de>
Message-ID: <543770E0.9040608@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

if there are no more comments, i will resend this patch set including
updates for irq-mxs driver.

Am 07.10.2014 um 10:55 schrieb Oleksij Rempel:
> This patchset provide initial support for Alpascale ASM9260,
> ARM based SoC.
> 
> Oleksij Rempel (9):
>   ARM: add mach-asm9260
>   arm: add lolevel debug support for asm9260
>   ARM: dts: add DT for Alphascale ASM9260 SoC
>   ARM: add alphascale,acc.txt bindings documentation
>   ARM: clk: add clk-asm9260 driver
>   clocksource: add asm9260_timer driver
>   irqchip/irq-mxs.c: add asm9260 support
>   tty/serial/mxs-auart.c: add initial Alphascale ASM9260 support
>   add Alphascale to vendor-prefixes.txt
> 
>  .../devicetree/bindings/clock/alphascale,acc.txt   | 113 +++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/Kconfig                                   |   2 +
>  arch/arm/Kconfig.debug                             |  33 +-
>  arch/arm/Makefile                                  |   1 +
>  arch/arm/boot/dts/Makefile                         |   2 +
>  arch/arm/boot/dts/alphascale-asm9260-devkit.dts    |  21 ++
>  arch/arm/boot/dts/alphascale-asm9260.dtsi          | 134 ++++++++
>  arch/arm/include/debug/asm9260.S                   |  31 ++
>  arch/arm/mach-asm9260/Kconfig                      |   8 +
>  arch/arm/mach-asm9260/Makefile                     |   1 +
>  arch/arm/mach-asm9260/core.c                       |  20 ++
>  drivers/clk/Makefile                               |   1 +
>  drivers/clk/clk-asm9260.c                          | 351 +++++++++++++++++++
>  drivers/clocksource/Kconfig                        |   4 +
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/asm9260_timer.c                | 234 +++++++++++++
>  drivers/irqchip/Kconfig                            |   5 +
>  drivers/irqchip/Makefile                           |   2 +-
>  drivers/irqchip/alphascale,asm9260-icoll.h         | 109 ++++++
>  drivers/irqchip/irq-mxs.c                          | 142 +++++++-
>  drivers/tty/serial/Kconfig                         |   5 +-
>  drivers/tty/serial/alphascale,asm9260_serial.h     | 373 +++++++++++++++++++++
>  drivers/tty/serial/mxs-auart.c                     | 344 ++++++++++++-------
>  include/dt-bindings/clock/alphascale,asm9260.h     |  97 ++++++
>  25 files changed, 1892 insertions(+), 143 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/alphascale,acc.txt
>  create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
>  create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi
>  create mode 100644 arch/arm/include/debug/asm9260.S
>  create mode 100644 arch/arm/mach-asm9260/Kconfig
>  create mode 100644 arch/arm/mach-asm9260/Makefile
>  create mode 100644 arch/arm/mach-asm9260/core.c
>  create mode 100644 drivers/clk/clk-asm9260.c
>  create mode 100644 drivers/clocksource/asm9260_timer.c
>  create mode 100644 drivers/irqchip/alphascale,asm9260-icoll.h
>  create mode 100644 drivers/tty/serial/alphascale,asm9260_serial.h
>  create mode 100644 include/dt-bindings/clock/alphascale,asm9260.h
> 


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141010/50bb47b5/attachment-0001.sig>
