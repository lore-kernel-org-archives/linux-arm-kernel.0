From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Jul 2011 01:20:18 +0800
Subject: [PATCH RESEND v3 0/2] Add device tree probe support for tty/serial/imx
Message-ID: <1309972820-18547-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch removes the use of cpu_is_mx1().  The second patch
adds device tree probe with a dependency on the following patch.

  http://article.gmane.org/gmane.linux.drivers.devicetree/6128

Changes with resend:
 * Fix typo
 * Change a few macros to inline functions

Changes since v2:
 * Not use generic naming imx-uart, instead use specific soc name
   to show uart type compatibility (Sascha's suggestion)

Changes since v1:
 * Address review comments given by Grant and Uwe

Shawn Guo (2):
      serial/imx: get rid of the uses of cpu_is_mx1()
      serial/imx: add device tree probe support

 .../bindings/tty/serial/fsl-imx-uart.txt           |   19 +++
 arch/arm/mach-imx/clock-imx1.c                     |    6 +-
 arch/arm/mach-imx/clock-imx21.c                    |    8 +-
 arch/arm/mach-imx/clock-imx25.c                    |   11 +-
 arch/arm/mach-imx/clock-imx27.c                    |   13 +-
 arch/arm/mach-imx/clock-imx31.c                    |   11 +-
 arch/arm/mach-imx/clock-imx35.c                    |    7 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   18 ++-
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |    7 +-
 drivers/tty/serial/imx.c                           |  167 +++++++++++++++++---
 10 files changed, 205 insertions(+), 62 deletions(-)
