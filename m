From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 Apr 2016 12:01:19 +0200
Subject: [GIT PULL 2/5] ARM: dts: exynos: DT for v4.7
In-Reply-To: <1460541682-32417-1-git-send-email-k.kozlowski@samsung.com>
References: <1460541682-32417-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1460541682-32417-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Device Tree changes, including the topic branch from 1/5.

Best regards,
Krzysztof


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.7

for you to fetch changes up to 06e520c4f067e7284fded10656acca924123c58e:

  ARM: dts: s5p: Fix DTC unit name warnings in SMDKv210 board (2016-04-13 11:14:52 +0200)

----------------------------------------------------------------
Samsung Device Tree updates and improvements for v4.7:
1. Enable accelerated AES (Security SubSystem) on Exynos4412-based boards.
2. Enable HDMI CEC on Exynos4412-based Odroid.
3. Add regulator supplies for eMMC/SD on Odroid XU3/XU4.
4. Fix DTC unit name warnings.
5. Merge topic branch of new Artik5 board.

----------------------------------------------------------------
Chanwoo Choi (6):
      dt-bindings: Add the clock id of UART2 and MMC2 for Exynos3250
      clk: samsung: exynos3250: Add MMC2 clock
      ARM: dts: exynos: Add initial pin configuration for exynos3250-rinato
      ARM: dts: exynos: Add initial gpio setting of MMC2 device for exynos3250-monk
      ARM: dts: exynos: Add MSHC2 DT node for Exynos3250 SoC
      ARM: dts: exynos: Add exynos3250-artik5 dtsi file for ARTIK5 module

Jaehoon Chung (1):
      ARM: dts: exynos: Add MSHC2 DT node for SD card for exynos3250-artik5-eval board

Kamil Debski (2):
      ARM: dts: exynos: Add HDMI CEC pin definition to exynos4 pinctrl
      ARM: dts: exynos: Add node for the HDMI CEC device to exynos4

Krzysztof Kozlowski (16):
      ARM: dts: exynos: Add Security SubSystem node to Exynos4
      ARM: dts: exynos: Enable SSS on Trats2
      ARM: dts: exynos: Enable SSS on Odroid X/X2/U3 family
      Merge tag 'clk-v4.7-exynos3250' of git://linuxtv.org/snawrocki/samsung into for-v4.7/dt-exynos3250-artik5
      Merge tag 'samsung-dt-exynos3250-artik5-4.7' into next/dt
      ARM: dts: exynos: Fix DTC unit name warnings in cros-adc-thermistors
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos3250
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos4
      ARM: dts: exynos: Fix DTC unit name warnings in Trats2 board
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos4x12
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos5250
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos542x
      ARM: dts: exynos: Fix DTC unit name warnings in Peach Pit
      ARM: dts: exynos: Fix DTC unit name warnings in SMDK5420
      ARM: dts: exynos: Fix DTC unit name warnings in Exynos5440
      ARM: dts: s5p: Fix DTC unit name warnings in SMDKv210 board

Marek Szyprowski (1):
      ARM: dts: exynos: Enable the HDMI CEC device on Exynos4412 Odroid boards

Markus Reichl (1):
      ARM: dts: exynos: Add eMMC and SD regulator supplies to Odroid XU3/XU4

Pankaj Dubey (2):
      clk: samsung: exynos3250: Add UART2 clock
      ARM: dts: exynos: Add UART2 DT node for Exynos3250 SoC

 .../bindings/arm/samsung/samsung-boards.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/cros-adc-thermistors.dtsi        |   8 +-
 arch/arm/boot/dts/exynos3250-artik5-eval.dts       |  43 +++
 arch/arm/boot/dts/exynos3250-artik5.dtsi           | 334 +++++++++++++++++++++
 arch/arm/boot/dts/exynos3250-monk.dts              |  12 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          |  80 +++++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  71 ++++-
 arch/arm/boot/dts/exynos3250.dtsi                  |  27 +-
 arch/arm/boot/dts/exynos4.dtsi                     |  23 +-
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          |   7 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   8 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |  16 +-
 arch/arm/boot/dts/exynos4x12-pinctrl.dtsi          |   7 +
 arch/arm/boot/dts/exynos4x12.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   8 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  12 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |   2 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |  10 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   6 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   2 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |  12 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  17 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |   4 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |   2 +-
 drivers/clk/samsung/clk-exynos3250.c               |  15 +
 include/dt-bindings/clock/exynos3250.h             |  11 +-
 28 files changed, 692 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5-eval.dts
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5.dtsi
