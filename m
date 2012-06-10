From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 10 Jun 2012 12:41:42 -0400
Subject: [PATCH 0/9] Kirkwood DT support For IRQ, SPI, I2C, GPIO
In-Reply-To: <1339324322-29388-1-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120610164142.GT14756@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 10, 2012 at 12:31:52PM +0200, Andrew Lunn wrote:
> This patch set adds Device Tree support for IRQ, SPI, I2C and GPIO on
> Orion based drivers, and makes use of these for kirkwood devices.  It
> also adds the ability to boot QNAP TS219 based systems using device
> tree.

Andrew, thanks for the patch series.  At first glance, things look good.
I'll let this sit on the mailinglist for a few days and try to test it
early this week.

thx,

Jason.

> The SPI DT patches are from Michael Walle, and have been previously
> posted. I've addressed the issues raised during the review.
> 
> The SPI refactor to use the SPI framework was submitted for merge into
> 3.5, but due to dependency issues, which are now resolved, the patch
> was not accepted. This patch has been modified to remove two NOP
> functions, which the SPI framework no longer needs.
> 
> Andrew Lunn (5):
>   ARM: Kirkwood: Add interrupt controller support for DT boards
>   SPI: Refactor spi-orion to use SPI framework queue.
>   I2C: MV64XXX: Add Device Tree support
>   ARM: Kirkwood: Add DT support for GPIO controllers
>   Kirkwood: Add basic device tree support for QNAP TS219.
> 
> Michael Walle (4):
>   spi-orion: remove uneeded spi_info
>   spi-orion: add device tree binding
>   ARM: kirkwood: use devicetree for orion-spi
>   ARM: kirkwood: use devicetree for SPI on dreamplug
> 
>  .../devicetree/bindings/arm/mrvl/intc.txt          |   20 ++
>  .../devicetree/bindings/gpio/mrvl-gpio.txt         |   25 +++
>  Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   35 ++-
>  .../devicetree/bindings/spi/spi-orion.txt          |    5 +
>  arch/arm/boot/dts/kirkwood-dreamplug.dts           |   29 +++
>  arch/arm/boot/dts/kirkwood-ts219-6281.dts          |   21 ++
>  arch/arm/boot/dts/kirkwood-ts219-6282.dts          |   21 ++
>  arch/arm/boot/dts/kirkwood-ts219.dtsi              |   73 +++++++
>  arch/arm/boot/dts/kirkwood.dtsi                    |   51 +++++
>  arch/arm/mach-kirkwood/Kconfig                     |   15 ++
>  arch/arm/mach-kirkwood/Makefile                    |    1 +
>  arch/arm/mach-kirkwood/Makefile.boot               |    1 +
>  arch/arm/mach-kirkwood/board-dreamplug.c           |   41 ----
>  arch/arm/mach-kirkwood/board-dt.c                  |   36 +++-
>  arch/arm/mach-kirkwood/board-ts219.c               |   86 ++++++++
>  arch/arm/mach-kirkwood/common.h                    |    5 +
>  arch/arm/mach-kirkwood/irq.c                       |   20 +-
>  arch/arm/plat-orion/gpio.c                         |   68 +++++-
>  arch/arm/plat-orion/include/plat/gpio.h            |    2 +
>  drivers/i2c/busses/i2c-mv64xxx.c                   |   38 +++-
>  drivers/spi/spi-orion.c                            |  223 ++++++--------------
>  21 files changed, 605 insertions(+), 211 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-orion.txt
>  create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6281.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ts219-6282.dts
>  create mode 100644 arch/arm/boot/dts/kirkwood-ts219.dtsi
>  create mode 100644 arch/arm/mach-kirkwood/board-ts219.c
> 
> -- 
> 1.7.10
> 
