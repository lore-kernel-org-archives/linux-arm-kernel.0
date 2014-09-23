From: srv_hongzhou.yang@mediatek.com (Hongzhou.Yang)
Date: Tue, 23 Sep 2014 11:39:01 +0800
Subject: [PATCH v2 0/4] Add Mediatek SoC Pinctrl/GPIO driver for MT8135. 
Message-ID: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of add Mediatek SoC Pinctrl/GPIO drvier for MT8135.
It is based on Joe.C' basic device tree support.
See http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/288582.html

This driver include common and MT8135 part, other Mediatek SoCs will share the common part,
and MT8135 part only support MT8135. MT8135 has GPIO controller, it includes 203 pins.

Changes in v2:
- According to Heiko Stubner' suggestion, use generic pinconfig.
- Remove pinmux_ops.disable implement.
- Due to limit of message body, move mt8135-pinfunc.h to '[PATCH 3/4] add pinctrl node for MT8135'.


Hongzhou Yang (3):
ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
dt-bindings: Add pinctrl bindings for mt65xx/mt81xx.
ARM: dts: mt8135: Add pinctrl node for mt8135.

Joe.C (1):
arm: mediatek: Add config option for mediatek SoCs.

.../devicetree/bindings/pinctrl/pinctrl-mt65xx.txt |   98 +
arch/arm/boot/dts/mt8135-pinfunc.h                 | 1304 +++++++++++
arch/arm/boot/dts/mt8135.dtsi                      |   11 +
arch/arm/mach-mediatek/Kconfig                     |   23 +-
drivers/pinctrl/Kconfig                            |    1 +
drivers/pinctrl/Makefile                           |    1 +
drivers/pinctrl/mediatek/Kconfig                   |   12 +
drivers/pinctrl/mediatek/Makefile                  |    5 +
drivers/pinctrl/mediatek/pinctrl-mt8135.c          |   82 +
drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  792 +++++++
drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |   95 +
drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h      | 2460 ++++++++++++++++++++
include/dt-bindings/pinctrl/mt65xx.h               |   23 +
13 files changed, 4904 insertions(+), 3 deletions(-)
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
