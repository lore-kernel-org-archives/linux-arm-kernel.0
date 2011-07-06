From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Jul 2011 00:37:40 +0800
Subject: [PATCH v3 0/3] Add device tree probe for imx/mxc gpio
Message-ID: <1309970263-13239-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch removes the uses of cpu_is_mx(), the second one
changes mxc gpio number macro, and the third one adds actual device
tree probe support.

Changes since v2:
 * Keep platform case gpio range code path unchanged, and get range
   from gpio core only for dt case.

Changes since v1:
 * Address review comments given by Grant and Sascha
 * Add patch #1 to get gpio range/base from gpio core

Shawn Guo (3):
      gpio/mxc: get rid of the uses of cpu_is_mx()
      ARM: mxc: use ARCH_NR_GPIOS to define gpio number
      gpio/mxc: add device tree probe support

 .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |   22 +++
 arch/arm/mach-imx/mm-imx1.c                        |    8 +-
 arch/arm/mach-imx/mm-imx21.c                       |   12 +-
 arch/arm/mach-imx/mm-imx25.c                       |    9 +-
 arch/arm/mach-imx/mm-imx27.c                       |   13 +-
 arch/arm/mach-imx/mm-imx31.c                       |    6 +-
 arch/arm/mach-imx/mm-imx35.c                       |    7 +-
 arch/arm/mach-mx5/mm-mx50.c                        |   13 +-
 arch/arm/mach-mx5/mm.c                             |   24 ++--
 arch/arm/plat-mxc/devices/platform-gpio-mxc.c      |    4 +-
 arch/arm/plat-mxc/include/mach/common.h            |    2 +-
 arch/arm/plat-mxc/include/mach/irqs.h              |   21 +---
 drivers/gpio/gpio-mxc.c                            |  157 +++++++++++++++++---
 13 files changed, 211 insertions(+), 87 deletions(-)
