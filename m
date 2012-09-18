From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Sep 2012 15:17:42 +0100
Subject: [PATCH v2 00/13] Versatile Express infrastructure
Message-ID: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This is a second version of the series I posted two weeks ago.
It has been heavily reworked based on feedback - mainly there
is no special bus_type and the interaction between a device
and a bridge is much more similar to what clocks/interrupts/
GPIOs are doing.

I believe I have Cc-ed all relevant maintainers (input,
fb, hwmon, regulators, common clock) in the subsystem-specific
patches (1 to 6). If the code looks good I'll prepare a git
pull request for Arnd and Olof with patches 7 to 13. I still
hope to get this series merged in 3.7 window.

Regards

Pawel


Pawel Moll (13):
  input: ambakmi: (Un)prepare clocks when (dis)enabling
  video: Versatile Express display output driver
  hwmon: Versatile Express hwmon driver
  regulators: Versatile Express regulator driver
  clk: Versatile Express clock generators ("osc") driver
  clk: Common clocks implementation for Versatile Express
  misc: Versatile Express config infrastructure
  mfd: Versatile Express system registers driver
  ARM: vexpress: Reset driver
  ARM: vexpress: Add config bus components and clocks to DTs
  ARM: vexpress: Start using new Versatile Express infrastructure
  ARM: vexpress: Remove motherboard dependencies in the DTS files
  ARM: vexpress: Make the DEBUG_LL UART detection more specific

 .../devicetree/bindings/arm/vexpress-sysreg.txt    |   50 ++
 Documentation/devicetree/bindings/arm/vexpress.txt |   68 ++-
 arch/arm/Kconfig                                   |    4 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  145 +++++-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  145 +++++-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  115 ++++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  179 ++++++-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |   79 ++-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  125 ++++-
 arch/arm/include/asm/hardware/sp810.h              |    6 +-
 arch/arm/mach-vexpress/Makefile                    |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   41 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |   10 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   81 ---
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   12 +-
 arch/arm/mach-vexpress/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/reset.c                     |  141 +++++
 arch/arm/mach-vexpress/v2m.c                       |  350 ++++---------
 drivers/clk/Kconfig                                |    8 +-
 drivers/clk/versatile/Makefile                     |    2 +
 drivers/clk/versatile/clk-vexpress-osc.c           |  146 ++++++
 drivers/clk/versatile/clk-vexpress.c               |  142 +++++
 drivers/hwmon/Kconfig                              |    8 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/vexpress.c                           |  330 ++++++++++++
 drivers/input/serio/ambakmi.c                      |    6 +-
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/vexpress-sysreg.c                      |  542 ++++++++++++++++++++
 drivers/misc/Kconfig                               |    6 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/vexpress-config.c                     |  276 ++++++++++
 drivers/regulator/Kconfig                          |    7 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/vexpress.c                       |  155 ++++++
 drivers/video/Makefile                             |    3 +
 drivers/video/vexpress-dvi.c                       |  208 ++++++++
 include/linux/vexpress.h                           |  100 ++++
 37 files changed, 3067 insertions(+), 432 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
 create mode 100644 arch/arm/mach-vexpress/reset.c
 create mode 100644 drivers/clk/versatile/clk-vexpress-osc.c
 create mode 100644 drivers/clk/versatile/clk-vexpress.c
 create mode 100644 drivers/hwmon/vexpress.c
 create mode 100644 drivers/mfd/vexpress-sysreg.c
 create mode 100644 drivers/misc/vexpress-config.c
 create mode 100644 drivers/regulator/vexpress.c
 create mode 100644 drivers/video/vexpress-dvi.c
 create mode 100644 include/linux/vexpress.h

-- 
1.7.9.5
