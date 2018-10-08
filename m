From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue,  9 Oct 2018 00:44:06 +0530
Subject: [PATCH 0/5] Add initial pinctrl support for MT6797 SoC
Message-ID: <20181008191411.32555-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds initial pinctrl support for Mediatek MT6797 SoC.
The pinctrl driver is based on the vendor binding as like MT6765 and
implements only GPIO and pinmux functionalities.

The devicetree binding doc is not added because it does not exist for
MT6765 and I'm not sure about the structure of it.

This patchset has been tested on 96Boards MediatekX20 development board.

Thanks,
Mani

Manivannan Sadhasivam (5):
  dt-bindings: pinctrl: Add devicetree constants for MT6797 SoC
  arm64: dts: mediatek: mt6797: Add pinctrl support
  arm64: dts: mediatek: x20: Add pinmux support for UART1
  pinctrl: mediatek: pinctrl-mtk-common-v2: Make eint_m u16
  pinctrl: mediatek: Add initial pinctrl driver for MT6797 SoC

 .../boot/dts/mediatek/mt6797-x20-dev.dts      |    2 +
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   21 +
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6797.c     |   82 +
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.h  |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h | 2430 +++++++++++++++++
 include/dt-bindings/pinctrl/mt6797-pinfunc.h  | 1368 ++++++++++
 8 files changed, 3912 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6797.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
 create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h

-- 
2.17.1
