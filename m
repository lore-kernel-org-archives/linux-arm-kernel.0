From: xuwei5@hisilicon.com (xuwei)
Date: Tue, 29 Jul 2014 15:44:10 +0800
Subject: [GIT PULL v2][for 3.17] pull request for hisilicon terminal soc
Message-ID: <53D750CA.5090405@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please help to merge pull request for hisilicon terminal soc. 

Best Regards,
Wei


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hix5hd2-for-3.17-v2

for you to fetch changes up to eeea1ab9b53f311f634e87d9208daa564a97dbba:

  ARM: hisi: remove smp from machine descriptor (2014-07-29 14:54:11 +0800)

----------------------------------------------------------------
ARM: mach-hisi: Hisilicon teminal soc udaptes for 3.17

- Rename Hi3716 to HiX5HD2
HiX5HD2 is a SoC with dual Cortex A9 cores for STB market.
And original Hi3xxx SoC is for mobile market.
To avoid confusing the two types of SoCs and also because of
different implementation(SMP, IPs integarted and earlycon configure),
rename Hi3716 to HIX5HD2 ann add ARCH_HIX5HD2.

- Add HiX5HD2 STB SoC and development kit board support
- Change to use power reset driver to reboot for HiX5HD2
- Add ARCH_HISI for the common configure of hisilicon SoCs
- Change to use CPU_METHOD_OF_DECLARE for SMP on HiX5HD2 and hi3xxx
- Enable L2 aux value for Hi3620

----------------------------------------------------------------
Haifeng Yan (3):
      ARM: debug: Rename Hi3716 to HIX5HD2
      ARM: hisi: enable hix5hd2 SoC
      ARM: dts: Add hix5hd2-dkb dts file.

Haojian Zhuang (5):
      ARM: hisi: add ARCH_HISI
      power: reset: move hisilicon reboot code
      ARM: config: enable ARCH_HIX5HD2
      ARM: hisi: set l2 aux for pl310
      ARM: hisi: remove smp from machine descriptor

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |  11 +++++++
 arch/arm/Kconfig.debug                                        |  12 ++++++--
 arch/arm/Makefile                                             |   2 +-
 arch/arm/boot/dts/Makefile                                    |   1 +
 arch/arm/boot/dts/hi3620.dtsi                                 |   1 +
 arch/arm/boot/dts/hix5hd2-dkb.dts                             |  53 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hix5hd2.dtsi                                | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hi3xxx_defconfig                             |   2 ++
 arch/arm/configs/multi_v7_defconfig                           |   1 +
 arch/arm/mach-hisi/Kconfig                                    |  30 +++++++++++++++++--
 arch/arm/mach-hisi/Makefile                                   |   2 +-
 arch/arm/mach-hisi/core.h                                     |   5 ++++
 arch/arm/mach-hisi/headsmp.S                                  |  16 +++++++++++
 arch/arm/mach-hisi/hisilicon.c                                |  45 +++++++----------------------
 arch/arm/mach-hisi/hotplug.c                                  |  58 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/platsmp.c                                  |  53 ++++++++++++++++++++++++++++++++--
 drivers/power/reset/Kconfig                                   |   6 ++++
 drivers/power/reset/Makefile                                  |   1 +
 drivers/power/reset/hisi-reboot.c                             |  67 +++++++++++++++++++++++++++++++++++++++++++
 19 files changed, 492 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm/boot/dts/hix5hd2-dkb.dts
 create mode 100644 arch/arm/boot/dts/hix5hd2.dtsi
 create mode 100644 arch/arm/mach-hisi/headsmp.S
 create mode 100644 drivers/power/reset/hisi-reboot.c
