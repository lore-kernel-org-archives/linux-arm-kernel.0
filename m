From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri,  4 May 2012 23:45:25 +0800
Subject: [PATCH 0/4] Add device tree support for gpio-mxs
Message-ID: <1336146329-3821-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up gpio-mxs a bit, and then adds device tree
support for the driver.  Currently, the irqdomain for gpio is still
added in platform code, and should be moved into driver later with the
help from the generic-irq-chip irqdomain support.

It's based on mxs device tree branch, and might be easier to go
via arm-soc tree.

Shawn Guo (4):
  gpio/mxs: use devm_* helpers to make error handling simple
  gpio/mxs: get rid of the use of cpu_is_xxx
  gpio/mxs: add device tree probe
  ARM: mxs: add gpio support for device tree boot

 .../devicetree/bindings/gpio/gpio-mxs.txt          |   87 +++++++++++
 arch/arm/boot/dts/imx23.dtsi                       |   35 +++++-
 arch/arm/boot/dts/imx28.dtsi                       |   55 +++++++-
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c      |   24 +---
 arch/arm/mach-mxs/include/mach/common.h            |    5 +-
 arch/arm/mach-mxs/mach-mxs.c                       |   12 ++
 arch/arm/mach-mxs/mm.c                             |   10 ++
 drivers/gpio/gpio-mxs.c                            |  156 ++++++++++++--------
 8 files changed, 296 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mxs.txt

-- 
1.7.5.4
