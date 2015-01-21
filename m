From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 21 Jan 2015 13:28:12 +0800
Subject: [PATCH v5 0/5] Add Mediatek SoC Pinctrl/GPIO/EINT driver for MT8135. 
Message-ID: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v5 of add Mediatek SoC Pinctrl/GPIO/EINT driver for MT8135.
It is based on Joe.C' basic device tree support.
See http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296093.html

This driver include common and MT8135 part, other Mediatek SoCs will share the common
part, and MT8135 part only support MT8135. MT8135 has GPIO controller, it includes 203 pins.

Changes in v5:
  - Modify devicetree binding format.

Changes in v4:
  - Add EINT support to this pinctrl driver.
  - Add input enable, SMT and drive strength support.
  - Add special control for pull config.
  - Use regmap_update_bits() for mux setting.
  - Modify mtk_desc_pin struct, and mtk_desc_eint_struct for EINT support.
  - Modify pinctrl-mtk-mt8135.h, add MTK_EINT_FUNCTION node, remove NULL functions.
  - Select GPIOLIB and OF_GPIO.
  - Use pinctrl util API for pinconf map.

Hongzhou Yang (3):
  dt-bindings: Add pinctrl bindings for mt65xx/mt81xx.
  ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
  ARM: dts: mt8135: Add pinctrl/GPIO/EINT node for mt8135.

Maoguang Meng (1):
  ARM: mediatek: Add EINT support to MTK pinctrl driver.

Yingjoe Chen (1):
  ARM: mediatek: Add config options for mediatek SoCs.

 .../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |  145 ++
 arch/arm/boot/dts/mt8135-pinfunc.h                 | 1302 ++++++++++++
 arch/arm/boot/dts/mt8135.dtsi                      |   25 +
 arch/arm/mach-mediatek/Kconfig                     |   23 +-
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/mediatek/Kconfig                   |   14 +
 drivers/pinctrl/mediatek/Makefile                  |    5 +
 drivers/pinctrl/mediatek/pinctrl-mt8135.c          |  373 ++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      | 1177 +++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |  218 ++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h      | 2114 ++++++++++++++++++++
 include/dt-bindings/pinctrl/mt65xx.h               |   40 +
 13 files changed, 5437 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt65xx.txt
 create mode 100644 arch/arm/boot/dts/mt8135-pinfunc.h
 create mode 100644 drivers/pinctrl/mediatek/Kconfig
 create mode 100644 drivers/pinctrl/mediatek/Makefile
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8135.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
 create mode 100644 include/dt-bindings/pinctrl/mt65xx.h

--
1.8.1.1.dirty
