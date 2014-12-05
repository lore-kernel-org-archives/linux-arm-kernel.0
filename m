From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 5 Dec 2014 18:37:43 +0800
Subject: [GIT PULL]Hisilicon hip01 soc and development board updates for 3.19
Message-ID: <54818AF7.5040801@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Could you please help to merge pull request for hisilicon hip01 soc and development board updates for 3.19?
I have tested it and it is OK.
Thanks!

Best Regards,
Wei


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hip01-for-3.19

for you to fetch changes up to 1512478332521bec0143e0632766400422752c17:

  ARM: hisi: enable smp for HiP01 (2014-12-05 18:05:40 +0800)

----------------------------------------------------------------
ARM: mach-hisi: Hisilicon hip01 soc and development board updates for 3.19

- Add hip01 debug UART
- Add hip01 DT_MACHINE and ARCH_HIP01 configure for it
- Add dts file for Hisilicon hip01 ca9x2 board
- Enable ARCH_HIP01 in the hisi_defconfig and multi_v7_defconfig
- Add a common smp_prepares_cpus function
- Rename hix5hd2_secondary_startup to hisi_secondary_startup
- Enable smp for HiP01

----------------------------------------------------------------
Wang Long (7):
      ARM: debug: add HiP01 debug uart
      ARM: hisi: enable HiP01 SoC
      ARM: dts: Add hip01-ca9x2 dts file
      ARM: config: enable ARCH_HIP01
      ARM: hisi: add a common smp_prepares_cpus function
      ARM: hisi: rename secondary_startup function
      ARM: hisi: enable smp for HiP01

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |  25 +++++++++++++++++++++++++
 arch/arm/Kconfig.debug                                        |  10 ++++++++++
 arch/arm/boot/dts/Makefile                                    |   1 +
 arch/arm/boot/dts/hip01-ca9x2.dts                             |  52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hip01.dtsi                                  | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hisi_defconfig                               |   1 +
 arch/arm/configs/multi_v7_defconfig                           |   1 +
 arch/arm/mach-hisi/Kconfig                                    |   8 ++++++++
 arch/arm/mach-hisi/core.h                                     |   5 ++++-
 arch/arm/mach-hisi/headsmp.S                                  |   2 +-
 arch/arm/mach-hisi/hisilicon.c                                |  10 ++++++++++
 arch/arm/mach-hisi/hotplug.c                                  |  31 +++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/platsmp.c                                  |  56 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 13 files changed, 307 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/hip01-ca9x2.dts
 create mode 100644 arch/arm/boot/dts/hip01.dtsi
