From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 16 Oct 2012 17:24:10 +0100
Subject: [GIT PULL] Versatile Express updates for v3.8
Message-ID: <1350404650.1242.20.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,
 
Would you be so kind to pull the updates for Versatile Express? It's the
same stuff as discussed last month (I've just added a couple of fixes
for bugs reported by Tixy) plus the hwmon driver (the maintainer acked
it and chosen to get it merged through the arm-soc tree).

Thanks!

Pawe?

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-v3.7-rc1

for you to fetch changes up to 1a84f27233a708e39e50d023e58b7ba14bf52171:

  ARM: vexpress: Make the debug UART detection more specific (2012-10-16 17:12:58 +0100)

----------------------------------------------------------------
Pawel Moll (8):
      hwmon: Versatile Express hwmon driver
      mfd: Versatile Express config infrastructure
      mfd: Versatile Express system registers driver
      ARM: vexpress: Reset driver
      ARM: vexpress: Add config bus components and clocks to DTs
      ARM: vexpress: Start using new Versatile Express infrastructure
      ARM: vexpress: Remove motherboard dependencies in the DTS files
      ARM: vexpress: Make the debug UART detection more specific

 .../devicetree/bindings/arm/vexpress-sysreg.txt    |   50 ++
 Documentation/devicetree/bindings/arm/vexpress.txt |   98 +++-
 .../devicetree/bindings/hwmon/vexpress.txt         |   23 +
 Documentation/hwmon/vexpress                       |   34 ++
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  146 +++++-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  146 +++++-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  121 ++++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  186 ++++++-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |   84 ++-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  136 ++++-
 arch/arm/include/asm/hardware/sp810.h              |    6 -
 arch/arm/include/debug/vexpress.S                  |   10 +-
 arch/arm/mach-vexpress/Kconfig                     |    4 +-
 arch/arm/mach-vexpress/Makefile                    |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   41 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   81 ---
 arch/arm/mach-vexpress/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/reset.c                     |  141 +++++
 arch/arm/mach-vexpress/v2m.c                       |  349 ++++---------
 drivers/hwmon/Kconfig                              |    8 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/vexpress.c                           |  229 ++++++++
 drivers/mfd/Kconfig                                |    6 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/vexpress-config.c                      |  277 ++++++++++
 drivers/mfd/vexpress-sysreg.c                      |  552 ++++++++++++++++++++
 include/linux/vexpress.h                           |  121 +++++
 27 files changed, 2435 insertions(+), 421 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/vexpress.txt
 create mode 100644 Documentation/hwmon/vexpress
 create mode 100644 arch/arm/mach-vexpress/reset.c
 create mode 100644 drivers/hwmon/vexpress.c
 create mode 100644 drivers/mfd/vexpress-config.c
 create mode 100644 drivers/mfd/vexpress-sysreg.c
 create mode 100644 include/linux/vexpress.h
