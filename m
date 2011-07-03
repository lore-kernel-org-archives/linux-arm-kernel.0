From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun,  3 Jul 2011 16:16:55 +0800
Subject: [PATCH 0/2] Add device tree probe for imx/mxc gpio
Message-ID: <1309681017-22970-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch removes the uses of cpu_is_mx(), and can be merged
right way when review gets done.  The second patch adds device tree
probe, and again depends on the patch adding of_alias_get_id()
support.

Shawn Guo (2):
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
 drivers/gpio/gpio-mxc.c                            |  163 +++++++++++++++++--
 12 files changed, 213 insertions(+), 64 deletions(-)
