From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 15 Jul 2014 13:11:42 +0200
Subject: [GIT PULL] Mediatek basic support for v3.17
Message-ID: <CABuKBe+h0Et5_+o4_i-Eu7EQ8Xka7YFoKmO=U0B7NnVQBdQ8FA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v3.17-next-basic-support

for you to fetch changes up to 747eec721f99b3d2eb3985c3199bfb54888c716d:

  arm: mediatek: add dts for Aquaris5 mobile phone (2014-07-15 11:15:00 +0200)

----------------------------------------------------------------
This patch set adds basic support for the Mediatek Cortex-A7 SoCs.
Support is quite basic, as the only component working up to now are the
timers.

----------------------------------------------------------------
Matthias Brugger (7):
      of: Provide function to request and map memory
      clocksource: Add support for the Mediatek SoCs
      dt-bindings: add mtk-timer bindings
      vendor-prefixes: add prefix for Mediatek Inc.
      arm: add basic support for Mediatek MT6589 boards
      dt-bindings: add documentation for Mediatek SoC
      arm: mediatek: add dts for Aquaris5 mobile phone

 Documentation/devicetree/bindings/arm/mediatek.txt |    8 +
 .../bindings/timer/mediatek,mtk-timer.txt          |   17 ++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/mt6589-aquaris5.dts              |   25 ++
 arch/arm/boot/dts/mt6589.dtsi                      |   94 +++++++
 arch/arm/mach-mediatek/Kconfig                     |    6 +
 arch/arm/mach-mediatek/Makefile                    |    1 +
 arch/arm/mach-mediatek/mediatek.c                  |   27 ++
 drivers/clocksource/Kconfig                        |    5 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/mtk_timer.c                    |  261 ++++++++++++++++++++
 drivers/of/address.c                               |   36 +++
 include/linux/io.h                                 |    2 +
 include/linux/of_address.h                         |   11 +
 lib/devres.c                                       |    2 -
 17 files changed, 498 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek.txt
 create mode 100644
Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
 create mode 100644 arch/arm/boot/dts/mt6589-aquaris5.dts
 create mode 100644 arch/arm/boot/dts/mt6589.dtsi
 create mode 100644 arch/arm/mach-mediatek/Kconfig
 create mode 100644 arch/arm/mach-mediatek/Makefile
 create mode 100644 arch/arm/mach-mediatek/mediatek.c
 create mode 100644 drivers/clocksource/mtk_timer.c
