From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 12 Jan 2015 17:04:36 +0800
Subject: [GIT PULL]Hisilicon hip01 soc and development board updates for 3.20
Message-ID: <54B38E24.6040901@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof, Hi Kevin, 

Could you please help to merge the pull request of hisilicon hip01 soc for 3.20. 
Thanks!

Best Regards,
Wei

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hip01-for-3.20

for you to fetch changes up to 3a1d691f244b54f59958e2294779ddc6905b1d8f:

  ARM: hisi: enable smp for HiP01 (2015-01-12 15:48:16 +0800)

----------------------------------------------------------------
ARM: mach-hisi: Hisilicon hip01 soc and development board updates for 3.20

- Add hip01 debug UART
- Add hip01 DT_MACHINE and ARCH_HIP01 configure item
- Add dts for Hisilicon hip01-ca9x2 board
- Enable ARCH_HIP01 in the hisi_defconfig and multi_v7_defconfig
- Add a common smp_prepares_cpus function
- Rename hix5hd2_secondary_startup to hisi_secondary_startup
- Enable smp for hip01

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
 arch/arm/boot/dts/hip01-ca9x2.dts                             |  51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hip01.dtsi                                  | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/configs/hisi_defconfig                               |   1 +
 arch/arm/configs/multi_v7_defconfig                           |   1 +
 arch/arm/mach-hisi/Kconfig                                    |   8 ++++++++
 arch/arm/mach-hisi/core.h                                     |   5 ++++-
 arch/arm/mach-hisi/headsmp.S                                  |   2 +-
 arch/arm/mach-hisi/hisilicon.c                                |  10 ++++++++++
 arch/arm/mach-hisi/hotplug.c                                  |  31 +++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/platsmp.c                                  |  56 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 13 files changed, 306 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/hip01-ca9x2.dts
 create mode 100644 arch/arm/boot/dts/hip01.dtsi
