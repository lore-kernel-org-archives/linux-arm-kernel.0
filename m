From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 27 Feb 2012 15:14:39 +0100
Subject: [GIT PULL] at91: irqdomain and device tree for AIC and GPIO
Message-ID: <4F4B8FCF.2050702@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds irqdomain and device tree support for both the
interrupt and GPIO controllers of AT91 SoC. It has been discussed a lot
and I think that I have addressed all comments and advices.

This irqdomain work takes advantage of Grant's patch series that is present
in:
git://git.secretlab.ca/git/linux-2.6 irqdomain/next
And it will not compile without it. So, the inclusion of such work is needed
before we can apply this series on mainline.

On the other hand, I have not included Grant's branch in mine on purpose: All
this simply goes on top of current AT91 material that is already in arm-soc
(merge of all at91/* branches). You can find it in the AT91 git tree with
at91-3.4-base2 branch name). I have made merge tests and all seems to integrate
without conflicts.


The following changes since commit 11a25ea7e4f870a37093258f577e11cec703e37e:

  Merge remote-tracking branch 'armsoc/at91/9x5' into at91-3.4-base2 (2012-02-11 14:33:03 +0100)

are available in the git repository at:


  git://github.com/at91linux/linux-at91.git at91-3.4-base2+aic_gpio

for you to fetch changes up to 29751864cc12425fe2b3a75658baea9ebe54609e:

  ARM: at91: AIC and GPIO IRQ device tree initialization (2012-02-27 14:38:08 +0100)

----------------------------------------------------------------
Nicolas Ferre (10):
      ARM: at91/aic: add irq domain and device tree support
      ARM: at91/snapper9260: move gpio_to_irq out of structure initialization
      ARM/USB: at91/ohci-at91: remove the use of irq_to_gpio
      ARM: at91/gpio: change comments and one variable name
      ARM: at91/gpio: add irqdomain and DT support
      ARM: at91/gpio: non-DT builds do not have gpio_chip.of_node field
      ARM: at91/gpio: add .to_irq gpio_chip handler
      ARM: at91/gpio: remove the static specification of gpio_chip.base
      ARM: at91/board-dt: remove AIC irq domain from board file
      ARM: at91: AIC and GPIO IRQ device tree initialization

 .../devicetree/bindings/arm/atmel-aic.txt          |   38 ++
 .../devicetree/bindings/gpio/gpio_atmel.txt        |   20 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   48 ++-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   66 +++-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    4 +
 arch/arm/mach-at91/board-dt.c                      |   13 +-
 arch/arm/mach-at91/board-snapper9260.c             |   10 +-
 arch/arm/mach-at91/generic.h                       |    6 +
 arch/arm/mach-at91/gpio.c                          |  363 ++++++++++++++++----
 arch/arm/mach-at91/include/mach/gpio.h             |   12 -
 arch/arm/mach-at91/irq.c                           |  132 ++++++--
 drivers/usb/host/ohci-at91.c                       |    5 +-
 13 files changed, 581 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/atmel-aic.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_atmel.txt

Thanks a lot, best regards,
-- 
Nicolas Ferre
