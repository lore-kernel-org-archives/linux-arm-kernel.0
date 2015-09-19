From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 19 Sep 2015 18:02:31 +0800
Subject: [PATCH 0/5] arm64: berlin: add pinctrl support
Message-ID: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Marvell berlin4ct pin-controller, allowing
to configure the pin muxing from the device tree.

This series applies on top of patches adding GPIO support for berlin4ct[1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-September/371106.html

Jisheng Zhang (5):
  pinctrl: berlin: regmap as an extra argument of berlin_pinctrl_probe()
  pinctrl: berlin: add the berlin4ct pinctrl driver
  arm64: berlin: add the pinctrl dependency for Marvell Berlin SoCs
  pinctrl: dt-binding: document berlin4ct SoC
  arm64: dts: berlin4ct: add the pinctrl node and muxing setup for uart0

 .../devicetree/bindings/pinctrl/berlin,pinctrl.txt |   5 +-
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi         |  27 ++
 drivers/pinctrl/berlin/Kconfig                     |   5 +
 drivers/pinctrl/berlin/Makefile                    |   1 +
 drivers/pinctrl/berlin/berlin-bg2.c                |   9 +-
 drivers/pinctrl/berlin/berlin-bg2cd.c              |   9 +-
 drivers/pinctrl/berlin/berlin-bg2q.c               |   9 +-
 drivers/pinctrl/berlin/berlin.c                    |   8 +-
 drivers/pinctrl/berlin/berlin.h                    |   1 +
 drivers/pinctrl/berlin/berlin4ct.c                 | 503 +++++++++++++++++++++
 11 files changed, 567 insertions(+), 11 deletions(-)
 create mode 100644 drivers/pinctrl/berlin/berlin4ct.c

-- 
2.5.1
