From: sravanhome@gmail.com (Saravanan Sekar)
Date: Sun, 22 Jul 2018 18:35:56 +0200
Subject: [PATCH 0/5] Add Actions Semi S700 pinctrl support
Message-ID: <20180722163601.28346-1-sravanhome@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds pinctrl support for Actions Semi S700 SoC.
Pinmux functions are only accessible for pin groups while pinconf
parameters are available for both pin groups and individual pins.

pinctrl driver is verified using the Cubieboard7.

common functionalities from s900 is moved for all Actions Semi
SoC's usage.
Common pad control configurations are moved to SoC specific

dts entry for pinctrl depends on clock driver which is still under review:
https://patchwork.kernel.org/patch/10533959/

Thanks,
Saravanan
Parthiban

Saravanan Sekar (5):
  pinctrl: actions: define constructor generic to Actions Semi SoC's
  pinctrl: actions: define pad control configurtion to SoC specific
  dt-bindings: pinctrl: Add bindings for Actions Semi S700 SoC
  pinctrl: actions: Add Actions Semi S700 pinctrl driver
  arm64: dts: actions: Add pinctrl node for Actions Semi S700

 .../bindings/pinctrl/actions,s700-pinctrl.txt |  162 ++
 arch/arm64/boot/dts/actions/s700.dtsi         |    6 +
 drivers/pinctrl/actions/Kconfig               |    6 +
 drivers/pinctrl/actions/Makefile              |    1 +
 drivers/pinctrl/actions/pinctrl-owl.c         |   64 +-
 drivers/pinctrl/actions/pinctrl-owl.h         |  135 +-
 drivers/pinctrl/actions/pinctrl-s700.c        | 1925 +++++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c        |  188 +-
 8 files changed, 2302 insertions(+), 185 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
 create mode 100644 drivers/pinctrl/actions/pinctrl-s700.c

-- 
2.18.0
