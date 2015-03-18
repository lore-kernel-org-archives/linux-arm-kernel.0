From: vincent.cw.yang@gmail.com (Vincent Yang)
Date: Wed, 18 Mar 2015 14:44:30 +0900
Subject: [GIT PULL] Support for Fujitsu MB86S7X SoCs
Message-ID: <CAKR0VNJdCEEoM8mqFrc-teQ-q=DopGisos16+uKt=ky2mRjF8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please consider pulling in these patches for series of Fujitsu SoC
based around variations of 2xCA7+2xCA15 big.LITTLE architecture.

The MHU driver is already queued in Mailbox tree.

Thanks,

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
s7x-arch-pull

for you to fetch changes up to 9cf417fee0bbea9296791fa9a15ab289307bb26a:

  ARM: MB86S7x: Add configs (2015-03-17 11:22:40 +0530)

----------------------------------------------------------------
Jassi Brar (6):
      ARM: Add platform support for Fujitsu MB86S7X SoCs
      ARM: MB86S7X: Add MCPM support
      clk: Add clock driver for mb86s7x
      dt: mb86s7x: add dt files for MB86S7x evbs
      of: add Fujitsu vendor prefix
      ARM: MB86S7x: Add configs

 Documentation/devicetree/bindings/arm/mb86s7x.txt  |   8 +
 .../bindings/clock/fujitsu,mb86s70-crg11.txt       |  26 +
 .../devicetree/bindings/soc/mb86s7x/scb_mhu.txt    |  35 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/mb86s70.dtsi                     |  91 ++++
 arch/arm/boot/dts/mb86s70eb.dts                    |  57 +++
 arch/arm/boot/dts/mb86s73.dtsi                     |  63 +++
 arch/arm/boot/dts/mb86s73eb.dts                    |  44 ++
 arch/arm/boot/dts/mb86s7x.dtsi                     | 142 ++++++
 arch/arm/configs/fujitsu_defconfig                 | 232 +++++++++
 arch/arm/configs/multi_v7_defconfig                |   5 +
 arch/arm/mach-mb86s7x/Kconfig                      |  19 +
 arch/arm/mach-mb86s7x/Makefile                     |   3 +
 arch/arm/mach-mb86s7x/board.c                      |  23 +
 arch/arm/mach-mb86s7x/mcpm.c                       | 318 +++++++++++++
 arch/arm/mach-mb86s7x/smc.S                        |  27 ++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-mb86s7x.c                          | 386 +++++++++++++++
 drivers/soc/Makefile                               |   1 +
 drivers/soc/mb86s7x/Makefile                       |   4 +
 drivers/soc/mb86s7x/scb_mhu.c                      | 529 +++++++++++++++++++++
 include/soc/mb86s7x/scb_mhu.h                      | 103 ++++
 26 files changed, 2131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mb86s7x.txt
 create mode 100644
Documentation/devicetree/bindings/clock/fujitsu,mb86s70-crg11.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mb86s7x/scb_mhu.txt
 create mode 100644 arch/arm/boot/dts/mb86s70.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s70eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s73.dtsi
 create mode 100644 arch/arm/boot/dts/mb86s73eb.dts
 create mode 100644 arch/arm/boot/dts/mb86s7x.dtsi
 create mode 100644 arch/arm/configs/fujitsu_defconfig
 create mode 100644 arch/arm/mach-mb86s7x/Kconfig
 create mode 100644 arch/arm/mach-mb86s7x/Makefile
 create mode 100644 arch/arm/mach-mb86s7x/board.c
 create mode 100644 arch/arm/mach-mb86s7x/mcpm.c
 create mode 100644 arch/arm/mach-mb86s7x/smc.S
 create mode 100644 drivers/clk/clk-mb86s7x.c
 create mode 100644 drivers/soc/mb86s7x/Makefile
 create mode 100644 drivers/soc/mb86s7x/scb_mhu.c
 create mode 100644 include/soc/mb86s7x/scb_mhu.h
