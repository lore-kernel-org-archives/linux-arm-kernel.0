From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 02 Sep 2014 21:05:36 +0530
Subject: [PATCH v2 0/7] arch: arm64: enable support for Samsung Exynos7 SoC
Message-ID: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Reduced the number of features targetted for the initial platform support.

This patchset supports new Exynos7 Samsung SoC based on Cortex-A57.
Exynos7 is a System-On-Chip (SoC) that is based on 64-bit
ARMv8 RISC processor.

NOTE:
We tested these patches with the 
"arm64: dts: add <dt-bindings/> symlink" change posted @
https://lkml.org/lkml/2014/9/1/688

The following patches are tested based on Kgene's for-next tree.
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next

The following patches are required for this series.
1- "irqchip: exynos-combiner: Fix compilation error on ARM64"
   https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg36209.html
2- "tty/serial: fix config dependencies for samsung serial"
   https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg36208.html

Alim Akhtar (1):
  arm64: exynos7: Enable ARMv8 based Exynos7 (SoC) support

Naveen Krishna Chatradhi (6):
  clk: samsung: add support for 145xx and 1460x PLLs
  clk: samsung: Factor out the common code to clk.c
  clk: samsung: Add fixed_factor_clocks field to struct exynos_cmu_info
  clk: samsung: add initial clock support for Exynos7 SoC
  tty/serial: samsung: enable usage for 64-bit Exynos platforms
  arm64: dts: Add initial device tree support for EXYNOS7

 .../devicetree/bindings/clock/exynos7-clock.txt    |   37 ++
 arch/arm64/Kconfig                                 |   12 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   31 ++
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  168 ++++++++
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos5260.c               |  183 ++------
 drivers/clk/samsung/clk-exynos7.c                  |  438 ++++++++++++++++++++
 drivers/clk/samsung/clk-pll.c                      |   25 +-
 drivers/clk/samsung/clk-pll.h                      |    4 +
 drivers/clk/samsung/clk.c                          |   98 +++++
 drivers/clk/samsung/clk.h                          |   37 ++
 drivers/tty/serial/Kconfig                         |    2 +-
 include/dt-bindings/clock/exynos7-clk.h            |   55 +++
 14 files changed, 929 insertions(+), 163 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos7-clock.txt
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos7.c
 create mode 100644 include/dt-bindings/clock/exynos7-clk.h

-- 
1.7.9.5
