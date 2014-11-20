From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Thu, 20 Nov 2014 20:27:22 +0800
Subject: [PATCH 0/9] Support for Fujitsu MB86S7X SoCs
Message-ID: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

  Fujitsu have a series of SoC already shipping based around
variations of 2xCA7+2xCA15 big.LITTLE architecture, and we would like
to upstream the basic support in this series.

  MB86S70 is a big.LITTLE platform with 2xCA7+2xCA15 and an additional
CM3 as the master. MB86S73 is a simple 2xCA7 and an additional CM3
master.

  The DT includes references to sdhci patches which are being sent to
  the mmc list at the same time.
  We welcome any comments or questions.

Thanks.

Vincent Yang (9):
  ARM: Add platform support for Fujitsu MB86S7X SoCs
  mailbox: arm_mhu: add driver for ARM MHU controller
  ARM: MB86S7X: Add MCPM support
  clk: Add clock driver for mb86s7x
  gpio: Add Fujitsu MB86S7x GPIO driver
  mmc: sdhci: host: add new f_sdh30
  dt: mb86s7x: add dt files for MB86S7x evbs
  of: add Fujitsu vendor prefix
  ARM: MB86S7x: Add configs

 Documentation/devicetree/bindings/arm/mb86s7x.txt  |   8 +
 .../bindings/clock/fujitsu,mb86s70-clk.txt         |  34 ++
 .../bindings/gpio/fujitsu,mb86s70-gpio.txt         |  18 +
 .../devicetree/bindings/mailbox/arm-mhu.txt        |  33 ++
 .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  35 ++
 .../devicetree/bindings/soc/mb86s7x/scb_mhu.txt    |  35 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/mb86s70.dtsi                     |  91 ++++
 arch/arm/boot/dts/mb86s70eb.dts                    |  52 ++
 arch/arm/boot/dts/mb86s73.dtsi                     |  49 ++
 arch/arm/boot/dts/mb86s73eb.dts                    |  39 ++
 arch/arm/boot/dts/mb86s7x.dtsi                     | 595 +++++++++++++++++++++
 arch/arm/configs/fujitsu_defconfig                 | 232 ++++++++
 arch/arm/configs/multi_v7_defconfig                |   5 +
 arch/arm/mach-mb86s7x/Kconfig                      |  19 +
 arch/arm/mach-mb86s7x/Makefile                     |   1 +
 arch/arm/mach-mb86s7x/board.c                      |  23 +
 arch/arm/mach-mb86s7x/mcpm.c                       | 360 +++++++++++++
 arch/arm/mach-mb86s7x/smc.S                        |  27 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-mb86s7x.c                          | 359 +++++++++++++
 drivers/gpio/Kconfig                               |   6 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-mb86s7x.c                        | 211 ++++++++
 drivers/mailbox/Kconfig                            |   7 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhu.c                          | 196 +++++++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci_f_sdh30.c                   | 319 +++++++++++
 drivers/soc/Makefile                               |   1 +
 drivers/soc/mb86s7x/Makefile                       |   4 +
 drivers/soc/mb86s7x/scb_mhu.c                      | 516 ++++++++++++++++++
 include/dt-bindings/clock/mb86s70-clk.h            |  22 +
 include/soc/mb86s7x/scb_mhu.h                      |  97 ++++
 39 files changed, 3420 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mb86s7x.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fujitsu,mb86s70-clk.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/fujitsu,mb86s70-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
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
 create mode 100644 drivers/gpio/gpio-mb86s7x.c
 create mode 100644 drivers/mailbox/arm_mhu.c
 create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
 create mode 100644 drivers/soc/mb86s7x/Makefile
 create mode 100644 drivers/soc/mb86s7x/scb_mhu.c
 create mode 100644 include/dt-bindings/clock/mb86s70-clk.h
 create mode 100644 include/soc/mb86s7x/scb_mhu.h

-- 
1.9.0
