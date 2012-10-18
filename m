From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 18 Oct 2012 18:05:17 +0100
Subject: [GIT PULL] vexpress: soc changes for v3.8
Message-ID: <1350579917.4984.19.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Could you, please, pull the Versatile Express SOC updates for 3.8?

Thanks!

Pawel

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-soc

for you to fetch changes up to f665f235c6ee31f84049920f16d1ff6e2dabc8f5:

  ARM: vexpress: Remove motherboard dependencies in the DTS files (2012-10-18 18:00:07 +0100)

----------------------------------------------------------------
Pawel Moll (5):
      mfd: Versatile Express config infrastructure
      mfd: Versatile Express system registers driver
      ARM: vexpress: Add config bus components and clocks to DTs
      ARM: vexpress: Start using new Versatile Express infrastructure
      ARM: vexpress: Remove motherboard dependencies in the DTS files

 .../devicetree/bindings/arm/vexpress-sysreg.txt    |   50 ++
 Documentation/devicetree/bindings/arm/vexpress.txt |   98 +++-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  146 +++++-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  146 +++++-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |  121 ++++-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  186 ++++++-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |   84 ++-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  136 ++++-
 arch/arm/include/asm/hardware/sp810.h              |    6 -
 arch/arm/mach-vexpress/Kconfig                     |    4 +-
 arch/arm/mach-vexpress/Makefile                    |    2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   41 +-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   81 ---
 arch/arm/mach-vexpress/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/v2m.c                       |  349 ++++---------
 drivers/mfd/Kconfig                                |    6 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/vexpress-config.c                      |  277 ++++++++++
 drivers/mfd/vexpress-sysreg.c                      |  552 ++++++++++++++++++++
 include/linux/vexpress.h                           |  121 +++++
 20 files changed, 1993 insertions(+), 417 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-sysreg.txt
 create mode 100644 drivers/mfd/vexpress-config.c
 create mode 100644 drivers/mfd/vexpress-sysreg.c
 create mode 100644 include/linux/vexpress.h
