From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Jul 2011 23:19:23 +0800
Subject: [PATCH v2 0/2] Add device tree probe for imx/mxc gpio
Message-ID: <1309879166-25788-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch removes the uses of cpu_is_mx(), and the second one
adds device tree probe support.

Changes since v1:
 * Address review comments given by Grant and Sascha
 * Add patch #1 to get gpio range/base from gpio core

Shawn Guo (3):
      gpio/mxc: get gpio range/base from gpio core
      gpio/mxc: get rid of the uses of cpu_is_mx()
      gpio/mxc: add device tree probe support

 .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |   22 +++
 arch/arm/mach-imx/mm-imx1.c                        |    8 +-
 arch/arm/mach-imx/mm-imx21.c                       |   12 +-
 arch/arm/mach-imx/mm-imx25.c                       |    8 +-
 arch/arm/mach-imx/mm-imx27.c                       |   12 +-
 arch/arm/mach-imx/mm-imx31.c                       |    6 +-
 arch/arm/mach-imx/mm-imx35.c                       |    6 +-
 arch/arm/mach-mx5/mm-mx50.c                        |   12 +-
 arch/arm/mach-mx5/mm.c                             |   22 ++--
 arch/arm/plat-mxc/devices/platform-gpio-mxc.c      |    4 +-
 arch/arm/plat-mxc/include/mach/common.h            |    2 +-
 arch/arm/plat-mxc/include/mach/gpio.h              |   13 +-
 arch/arm/plat-mxc/include/mach/irqs.h              |   21 +--
 drivers/gpio/gpio-mxc.c                            |  165 ++++++++++++++++---
 14 files changed, 219 insertions(+), 94 deletions(-)
