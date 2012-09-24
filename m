From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Sep 2012 16:53:00 +0100
Subject: [GIT PULL] Veratile Express updates for v3.7
Message-ID: <1348501980.27071.8.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Ofof,

Would you be so kind to pull the updates for Versatile Express based on
v3.6-rc7 discussed over the last couple of weeks?

Thanks!

Pawel

The following changes since commit 979570e02981d4a8fc20b3cc8fd651856c98ee9d:

  Linux 3.6-rc7 (2012-09-23 18:10:57 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-v3.6-rc7

for you to fetch changes up to 4fe4cef545679d299f8abbc2573c2ef2d0f4c268:

  ARM: vexpress: Make the DEBUG_LL UART detection more specific (2012-09-24 16:15:35 +0100)

----------------------------------------------------------------
Pawel Moll (7):
      mfd: Versatile Express config infrastructure
      mfd: Versatile Express system registers driver
      ARM: vexpress: Reset driver
      ARM: vexpress: Add config bus components and clocks to DTs
      ARM: vexpress: Start using new Versatile Express infrastructure
      ARM: vexpress: Remove motherboard dependencies in the DTS files
      ARM: vexpress: Make the DEBUG_LL UART detection more specific

 .../devicetree/bindings/arm/vexpress-sysreg.txt    |   50 ++
 Documentation/devicetree/bindings/arm/vexpress.txt |   68 ++-
 arch/arm/Kconfig                                   |    4 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  146 +++++-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  146 +++++-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  116 ++++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  181 ++++++-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |   79 ++-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  131 ++++-
 arch/arm/include/asm/hardware/sp810.h              |    6 -
 arch/arm/mach-vexpress/Makefile                    |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   41 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |   10 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   81 ---
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   12 +-
 arch/arm/mach-vexpress/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/reset.c                     |  141 +++++
 arch/arm/mach-vexpress/v2m.c                       |  350 ++++---------
 drivers/mfd/Kconfig                                |    6 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/vexpress-config.c                      |  276 ++++++++++
 drivers/mfd/vexpress-sysreg.c                      |  542 ++++++++++++++++++++
 include/linux/vexpress.h                           |  100 ++++
 23 files changed, 2065 insertions(+), 427 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
 create mode 100644 arch/arm/mach-vexpress/reset.c
 create mode 100644 drivers/mfd/vexpress-config.c
 create mode 100644 drivers/mfd/vexpress-sysreg.c
 create mode 100644 include/linux/vexpress.h
