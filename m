From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 9 Oct 2015 14:51:56 +0800
Subject: [PATCH v3 0/6] arm64: berlin: add pinctrl support
Message-ID: <1444373522-2119-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Marvell berlin4ct pin-controller, allowing
to configure the pin muxing from the device tree.

Since v2:
 - introduce new berlin_pinctrl_probe_regmap() to avoid duplicated code
 - renaming such as s/urt/uart etc. but keep the group name as URT* to keep
   consistent with HW/ASIC

Since v1:
 - use generic name for pin functions
 - a new commit to add pinmux for uart0
 - correct pinctrl usage in dts


Jisheng Zhang (6):
  pinctrl: berlin: introduce berlin_pinctrl_probe_regmap()
  pinctrl: berlin: add the berlin4ct pinctrl driver
  arm64: berlin: add the pinctrl dependency for Marvell Berlin SoCs
  pinctrl: dt-binding: document berlin4ct SoC pinctrl
  arm64: dts: berlin4ct: add the pinctrl node
  arm64: dts: berlin4ct: add default pinmux for uart0

 .../devicetree/bindings/pinctrl/berlin,pinctrl.txt |   5 +-
 arch/arm64/Kconfig.platforms                       |   1 +
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi         |  22 +
 drivers/pinctrl/berlin/Kconfig                     |   5 +
 drivers/pinctrl/berlin/Makefile                    |   1 +
 drivers/pinctrl/berlin/berlin-bg4ct.c              | 503 +++++++++++++++++++++
 drivers/pinctrl/berlin/berlin.c                    |  26 +-
 drivers/pinctrl/berlin/berlin.h                    |   4 +
 8 files changed, 557 insertions(+), 10 deletions(-)
 create mode 100644 drivers/pinctrl/berlin/berlin-bg4ct.c

-- 
2.6.1
