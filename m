From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:20 +0100
Subject: [PATCH 00/11] Versatile Express infrastructure
Message-ID: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This series is a complete set of patches implementing platform
control infrastructure, clocking etc. It is sent as a one off
for completeness, but eventually ambakmi, hwmon and regulators
patches will go through their subsystems.

The clocking patches depend on Linus Walleij's "clk: convert
ARM RealView to common clk" and should go through Mike
Turquette's tree. I am a little bit worried about merging
this, as it depends on the "config_bus" infrastructure which
should go through arm-soc. Any ideas and suggestions more
then welcome.

Most of the random bits and pieces (reset controllers and alike)
are located in drivers/misc/vexpress now, and I'm more than
happy to move them if anyone has better idea.

Regards

Pawel


Pawel Moll (11):
  input: ambakmi: Add missing clk_[un]prepare() calls
  misc: Versatile Express config bus infrastructure
  misc: Versatile Express reset driver
  misc: Versatile Express display muxer driver
  clk: Versatile Express clock generators ("osc") driver
  clk: Common clocks implementation for Versatile Express
  regulators: Versatile Express regulator driver
  hwmon: Versatile Express hwmon driver
  misc: Versatile Express system registers driver
  ARM: vexpress: Add config bus components and clocks to DTs
  ARM: vexpress: Start using new Versatile Express infrastructure

 Documentation/devicetree/bindings/arm/vexpress.txt |  173 +++++-
 arch/arm/Kconfig                                   |    4 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  136 ++++-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  136 ++++-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  103 ++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  169 ++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |   71 +++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  121 ++++
 arch/arm/include/asm/hardware/sp810.h              |    6 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   37 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   81 ---
 arch/arm/mach-vexpress/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/v2m.c                       |  321 +++--------
 drivers/clk/Kconfig                                |    8 +-
 drivers/clk/versatile/Makefile                     |    2 +
 drivers/clk/versatile/clk-vexpress-osc.c           |  154 +++++
 drivers/clk/versatile/clk-vexpress.c               |  174 ++++++
 drivers/hwmon/Kconfig                              |    8 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/vexpress.c                           |  275 +++++++++
 drivers/input/serio/ambakmi.c                      |    9 +-
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/vexpress/Kconfig                      |    5 +
 drivers/misc/vexpress/Makefile                     |    4 +
 drivers/misc/vexpress/config_bus.c                 |  596 ++++++++++++++++++++
 drivers/misc/vexpress/display.c                    |  197 +++++++
 drivers/misc/vexpress/reset.c                      |  110 ++++
 drivers/misc/vexpress/sysreg.c                     |  423 ++++++++++++++
 drivers/regulator/Kconfig                          |    7 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/vexpress.c                       |  144 +++++
 include/linux/vexpress.h                           |  150 +++++
 33 files changed, 3257 insertions(+), 374 deletions(-)
 create mode 100644 drivers/clk/versatile/clk-vexpress-osc.c
 create mode 100644 drivers/clk/versatile/clk-vexpress.c
 create mode 100644 drivers/hwmon/vexpress.c
 create mode 100644 drivers/misc/vexpress/Kconfig
 create mode 100644 drivers/misc/vexpress/Makefile
 create mode 100644 drivers/misc/vexpress/config_bus.c
 create mode 100644 drivers/misc/vexpress/display.c
 create mode 100644 drivers/misc/vexpress/reset.c
 create mode 100644 drivers/misc/vexpress/sysreg.c
 create mode 100644 drivers/regulator/vexpress.c
 create mode 100644 include/linux/vexpress.h

-- 
1.7.9.5
