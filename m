From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Sep 2014 11:12:51 -0700
Subject: [GIT PULL] RealView Device Tree support for v3.18
Message-ID: <CACRpkdbHcJgnXDxO=yjuqbppT6OSR=N=4T80FFsrwKNM9Dy=sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

this is the push forward for DT on the ARM RealView boards.
I've tried to fix up the patches and get ACKs from the maintainers
as far as possible.

Outstanding issue: no ACK from LED maintainers Bryan Wu or
Richard Purdie on the syscon LED stuff. I have requested this
early in the series and now for two weeks on the latest patch set.
The driver is reviewed by others, I foresee no problems with
merging it.

The rest is throroughly reviewed and discussions on the DT
bindings appear to have settled.

Please pull this in so we can get some rotation in linux-next now,
we need to move forward with device tree conversion.

Yours,
Linus Walleij

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-dt-for-v3.18

for you to fetch changes up to 56660647c5400f6ea2b3497f112f036e744cf75b:

  ARM: realview: basic device tree implementation (2014-09-19 13:00:34 -0500)

----------------------------------------------------------------
This is the RealView Device Tree support branch for v3.18
- A new syscon LEDs driver
- A new reset driver for the versatile family
- Setting up the L2$ from DT
- Base DT support code for all RealView boards
- Booting to serial console plus LEDs and reset on PB1176

----------------------------------------------------------------
Linus Walleij (6):
      leds: add a driver for syscon-based LEDs
      leds: add device tree bindings for register bit LEDs
      power: reset: driver for the Versatile syscon reboot
      soc: add driver for the ARM RealView
      ARM: l2c: parse cache properties from ePAPR definitions
      ARM: realview: basic device tree implementation

 Documentation/devicetree/bindings/arm/arm-boards   |  65 ++++++
 Documentation/devicetree/bindings/arm/gic.txt      |   1 +
 Documentation/devicetree/bindings/arm/l2cc.txt     |  10 +
 .../devicetree/bindings/leds/register-bit-led.txt  |  99 +++++++++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/arm-realview-pb1176.dts          | 247 +++++++++++++++++++++
 arch/arm/mach-realview/Kconfig                     |  13 ++
 arch/arm/mach-realview/Makefile                    |   1 +
 arch/arm/mach-realview/realview-dt.c               |  32 +++
 arch/arm/mm/cache-l2x0.c                           | 121 ++++++++++
 drivers/irqchip/irq-gic.c                          |   2 +
 drivers/leds/Kconfig                               |  10 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-syscon.c                         | 166 ++++++++++++++
 drivers/power/reset/Kconfig                        |   9 +
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/arm-versatile-reboot.c         | 111 +++++++++
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/versatile/Kconfig                      |  10 +
 drivers/soc/versatile/Makefile                     |   1 +
 drivers/soc/versatile/soc-realview.c               | 144 ++++++++++++
 22 files changed, 1047 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/register-bit-led.txt
 create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
 create mode 100644 arch/arm/mach-realview/realview-dt.c
 create mode 100644 drivers/leds/leds-syscon.c
 create mode 100644 drivers/power/reset/arm-versatile-reboot.c
 create mode 100644 drivers/soc/versatile/Kconfig
 create mode 100644 drivers/soc/versatile/Makefile
 create mode 100644 drivers/soc/versatile/soc-realview.c
