From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 18 Jul 2013 22:34:51 +0400
Subject: [PATCH 00/10] ARM: clps711x: Initial DT support / Fixes
Message-ID: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is next patchset for the Cirrus Logic CLPS711X target CPUs.
The first four patches is a small fixes. The rest is a attempt
to add DT support for this subarch.
As long as DT support is incomplete (no peripherals), I did not
add DTS yet. This is the next step.

Alexander Shiyan (10):
  ARM: clps711x: Remove the special name for the syscon driver
  ARM: clps711x: Drop fortunet board support
  ARM: clps711x: autcpu12: Remove incorrect config checking
  ARM: clps711x: edb7211: Remove extra iotable_init() call
  ARM: clps711x: Add CLPS711X clk driver
  ARM: clps711x: Add CLPS711X clocksource driver
  ARM: clps711x: Add CLPS711X irqchip driver
  ARM: clps711x: Add CLPS711X cpuidle driver
  ARM: clps711x: Migrate CLPS711X subarch to the new basic drivers
  ARM: clps711x: Add initial DT support

 .../devicetree/bindings/clock/clps711x-clock.txt   |  47 +++
 .../interrupt-controller/cirrus,clps711x-intc.txt  |  42 +++
 arch/arm/Kconfig                                   |   5 -
 arch/arm/mach-clps711x/Kconfig                     |   8 +-
 arch/arm/mach-clps711x/Makefile                    |   2 +-
 arch/arm/mach-clps711x/board-autcpu12.c            |   9 +-
 arch/arm/mach-clps711x/board-cdb89712.c            |   3 -
 arch/arm/mach-clps711x/board-clep7312.c            |   3 -
 arch/arm/mach-clps711x/board-dt.c                  |  56 ++++
 arch/arm/mach-clps711x/board-edb7211.c             |  20 +-
 arch/arm/mach-clps711x/board-fortunet.c            |  85 -----
 arch/arm/mach-clps711x/board-p720t.c               |   3 -
 arch/arm/mach-clps711x/common.c                    | 345 +--------------------
 arch/arm/mach-clps711x/common.h                    |   3 -
 arch/arm/mach-clps711x/devices.c                   |  12 +-
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-clps711x.c                         | 150 +++++++++
 drivers/clocksource/Kconfig                        |   6 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/clps711x-clksrc.c              | 151 +++++++++
 drivers/cpuidle/Kconfig                            |   6 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-clps711x.c                 |  80 +++++
 drivers/irqchip/Kconfig                            |   6 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-clps711x.c                     | 277 +++++++++++++++++
 drivers/mfd/syscon.c                               |   3 -
 27 files changed, 851 insertions(+), 475 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/clps711x-clock.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
 create mode 100644 arch/arm/mach-clps711x/board-dt.c
 delete mode 100644 arch/arm/mach-clps711x/board-fortunet.c
 create mode 100644 drivers/clk/clk-clps711x.c
 create mode 100644 drivers/clocksource/clps711x-clksrc.c
 create mode 100644 drivers/cpuidle/cpuidle-clps711x.c
 create mode 100644 drivers/irqchip/irq-clps711x.c

-- 
1.8.1.5
