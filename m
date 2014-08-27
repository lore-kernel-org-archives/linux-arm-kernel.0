From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Wed, 27 Aug 2014 15:14:16 +0530
Subject: [PATCH 00/14] Support 64bit Cortex A57 based Exynos7 SoC
Message-ID: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset supports new Exynos7 Samsung SoC based on Cortex-A57.
Exynos7 is a System-On-Chip (SoC) that is based on 64-bit
ARMv8 RISC processor.

This patchset includes the following:
- Support for pinctrl on Exynos7
- Support for clock control on Exynos7 using common clk framework
- DTS and DTSI file addition for Exynos7 based Espresso board
- Support for serial driver on Exynos7
- Support for HSI2C driver on Exynos7
- Support for Watchdog driver on Exynos7

NOTE:
We tested these patches with the 
"arm64: dts: add <dt-bindings/> symlink" change posted @
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/224629.html

The following patches are tested based on Kgene's for-next tree.
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next

Alim Akhtar (2):
  arm64: exynos7: Enable ARMv8 based Exynos7 (SoC) support
  tty/serial: samsung: add support for exynos7

Naveen Krishna Chatradhi (12):
  clk: samsung: add support for 145xx and 1460x PLLs
  clk: samsung: Factor out the common code to clk.c
  clk: samsung: Add fixed_factor_clocks field to struct exynos_cmu_info
  clk: samsung: Add clock description for basic CMU blocks
  pinctrl: exynos: Add driver data for Exynos7
  pinctrl: samsung: use CONFIG_PINCTRL_SAMSUNG symbol in makefile
  i2c: exynos: add support for HSI2C module on Exynos7
  i2c: exynos5: Add Kconfig dependencies
  watchdog: s3c2410_wdt: Add support for Watchdog device on Exynos7
  arm64: dts: add pinctrl support to EXYNOS7
  arm64: dts: Add initial device tree support for EXYNOS7
  arm64: dts: add Exynos7 based Espresso board dts file

 .../devicetree/bindings/clock/exynos7-clock.txt    |  209 +++
 .../devicetree/bindings/i2c/i2c-exynos5.txt        |    2 +
 .../bindings/pinctrl/samsung-pinctrl.txt           |    1 +
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |    1 +
 arch/arm64/Kconfig                                 |   17 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/exynos7-espresso.dts           |   69 +
 arch/arm64/boot/dts/exynos7-pinctrl.dtsi           |  691 +++++++
 arch/arm64/boot/dts/exynos7.dtsi                   |  553 ++++++
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos5260.c               |  181 +-
 drivers/clk/samsung/clk-exynos7.c                  | 1929 ++++++++++++++++++++
 drivers/clk/samsung/clk-pll.c                      |   50 +-
 drivers/clk/samsung/clk-pll.h                      |    4 +
 drivers/clk/samsung/clk.c                          |  104 ++
 drivers/clk/samsung/clk.h                          |   37 +
 drivers/i2c/busses/Kconfig                         |    2 +-
 drivers/i2c/busses/i2c-exynos5.c                   |   71 +-
 drivers/pinctrl/Makefile                           |    2 +-
 drivers/pinctrl/samsung/Kconfig                    |    2 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  145 ++
 drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    1 +
 drivers/tty/serial/Kconfig                         |    6 +-
 drivers/tty/serial/samsung.c                       |    2 +-
 drivers/watchdog/s3c2410_wdt.c                     |   11 +
 include/dt-bindings/clock/exynos7-clk.h            |  236 +++
 27 files changed, 4151 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos7-clock.txt
 create mode 100644 arch/arm64/boot/dts/exynos7-espresso.dts
 create mode 100644 arch/arm64/boot/dts/exynos7-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos7.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos7.c
 create mode 100644 include/dt-bindings/clock/exynos7-clk.h

-- 
1.7.9.5
