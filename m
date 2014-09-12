From: xuwei5@hisilicon.com (xuwei)
Date: Fri, 12 Sep 2014 15:31:53 +0800
Subject: [GIT PULL][for 3.18]pull request for hisilicon hip04 soc and D01
 board updates
Message-ID: <5412A169.5020308@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please help to merge pull request for hisilicon hip04 soc and D01 board updates for 3.18. 
Thanks!

Best Regards,
Wei


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/D01-for-3.18

for you to fetch changes up to c9a1df48a97ac9141540f177e4293a9966348f8c:

  ARM: debug: add HiP04 debug uart (2014-09-03 14:10:46 +0100)

----------------------------------------------------------------
ARM: mach-hisi: Hisilicon hip04 soc and D01 board updates for 3.18

- Add the CONFIG_MCPM_QUAD_CLUSTER configuration to enlarge cluster number from 2 to 4
- Enable MCPM on HiP04 SoC
- Enable 16 cores on HiP04 SoC
- Add platform & Fabric controller devicetree binding document for HiP04 SoC
- Add hip04.dtsi & hip04-d01.dts for hip04 SoC platform and D01 board
- Enable HiP04 SoC in both hi3xxx_defconfig & multi_v7_defconfig
- Add the support of Hisilicon HiP04 debug uart

----------------------------------------------------------------
Haojian Zhuang (7):
      ARM: mcpm: support 4 clusters
      ARM: hisi: enable MCPM implementation
      ARM: hisi: enable HiP04
      document: dt: add the binding on HiP04
      ARM: dts: add hip04 dts
      ARM: config: enable hisilicon hip04
      ARM: debug: add HiP04 debug uart

 Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt |  23 +++++++
 arch/arm/Kconfig                                              |   9 +++
 arch/arm/Kconfig.debug                                        |  10 +++
 arch/arm/boot/dts/Makefile                                    |   1 +
 arch/arm/boot/dts/hip04-d01.dts                               |  32 +++++++++
 arch/arm/boot/dts/hip04.dtsi                                  | 267 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/{hi3xxx_defconfig => hisi_defconfig}         |  13 ++++
 arch/arm/configs/multi_v7_defconfig                           |   1 +
 arch/arm/include/asm/mcpm.h                                   |   5 ++
 arch/arm/mach-hisi/Kconfig                                    |   9 +++
 arch/arm/mach-hisi/Makefile                                   |   1 +
 arch/arm/mach-hisi/hisilicon.c                                |   9 +++
 arch/arm/mach-hisi/platmcpm.c                                 | 386 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 766 insertions(+)
 create mode 100644 arch/arm/boot/dts/hip04-d01.dts
 create mode 100644 arch/arm/boot/dts/hip04.dtsi
 rename arch/arm/configs/{hi3xxx_defconfig => hisi_defconfig} (77%)
 create mode 100644 arch/arm/mach-hisi/platmcpm.c
