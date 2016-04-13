From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 13 Apr 2016 12:01:18 +0200
Subject: [GIT PULL 1/5] ARM: dts: exynos: Artik5 topic branch for v4.7
In-Reply-To: <1460541682-32417-1-git-send-email-k.kozlowski@samsung.com>
References: <1460541682-32417-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1460541682-32417-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


This is a topic branch including dependency - clocks. It adds new board:
Exynos3250-based Artik5.


Best regards,
Krzysztof


Below you will find two pull-diffs, for my changes and for
everything (including dependency):
##################################################################
The following changes since commit a8b41ea4babb4bdf8ba3b078e1c6761189d29eb7:

  Merge tag 'clk-v4.7-exynos3250' of git://linuxtv.org/snawrocki/samsung into for-v4.7/dt-exynos3250-artik5 (2016-04-01 02:09:43 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-exynos3250-artik5-4.7

for you to fetch changes up to e70c7ae1c594300660a552773c12aa9945770ae6:

  ARM: dts: exynos: Add MSHC2 DT node for SD card for exynos3250-artik5-eval board (2016-04-01 09:22:46 +0900)

----------------------------------------------------------------
Topic branch for Device Tree changes for Exynos 3250 for v4.7:

Merge necessary new clocks from Sylwester (used by new board) and add support
for Exynos3250-based Artik5 board.

----------------------------------------------------------------
Chanwoo Choi (4):
      ARM: dts: exynos: Add initial pin configuration for exynos3250-rinato
      ARM: dts: exynos: Add initial gpio setting of MMC2 device for exynos3250-monk
      ARM: dts: exynos: Add MSHC2 DT node for Exynos3250 SoC
      ARM: dts: exynos: Add exynos3250-artik5 dtsi file for ARTIK5 module

Jaehoon Chung (1):
      ARM: dts: exynos: Add MSHC2 DT node for SD card for exynos3250-artik5-eval board

Pankaj Dubey (1):
      ARM: dts: exynos: Add UART2 DT node for Exynos3250 SoC

 Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt |   2 +
 arch/arm/boot/dts/Makefile                                       |   1 +
 arch/arm/boot/dts/exynos3250-artik5-eval.dts                     |  43 +++++++++++++++++
 arch/arm/boot/dts/exynos3250-artik5.dtsi                         | 334 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos3250-monk.dts                            |  12 ++++-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi                        |  80 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos3250-rinato.dts                          |  71 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/exynos3250.dtsi                                |  25 ++++++++++
 8 files changed, 565 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5-eval.dts
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5.dtsi

##################################################################


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-exynos3250-artik5-4.7

for you to fetch changes up to e70c7ae1c594300660a552773c12aa9945770ae6:

  ARM: dts: exynos: Add MSHC2 DT node for SD card for exynos3250-artik5-eval board (2016-04-01 09:22:46 +0900)

----------------------------------------------------------------
Topic branch for Device Tree changes for Exynos 3250 for v4.7:

Merge necessary new clocks from Sylwester (used by new board) and add support
for Exynos3250-based Artik5 board.

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

Krzysztof Kozlowski (1):
      Merge tag 'clk-v4.7-exynos3250' of git://linuxtv.org/snawrocki/samsung into for-v4.7/dt-exynos3250-artik5

Pankaj Dubey (2):
      clk: samsung: exynos3250: Add UART2 clock
      ARM: dts: exynos: Add UART2 DT node for Exynos3250 SoC

 .../bindings/arm/samsung/samsung-boards.txt        |   2 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos3250-artik5-eval.dts       |  43 +++
 arch/arm/boot/dts/exynos3250-artik5.dtsi           | 334 +++++++++++++++++++++
 arch/arm/boot/dts/exynos3250-monk.dts              |  12 +-
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          |  80 +++++
 arch/arm/boot/dts/exynos3250-rinato.dts            |  71 ++++-
 arch/arm/boot/dts/exynos3250.dtsi                  |  25 ++
 drivers/clk/samsung/clk-exynos3250.c               |  15 +
 include/dt-bindings/clock/exynos3250.h             |  11 +-
 10 files changed, 590 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5-eval.dts
 create mode 100644 arch/arm/boot/dts/exynos3250-artik5.dtsi
