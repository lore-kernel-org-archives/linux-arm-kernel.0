From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Wed,  7 Nov 2018 23:18:40 +0530
Subject: [PATCH v3 0/4] Add initial pinctrl support for MT6797 SoC
Message-ID: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds initial pinctrl support for Mediatek MT6797 SoC.
The pinctrl driver is based on the vendor binding as like MT6765 and
implements only GPIO and pinmux functionalities.

The devicetree binding document consists of pinmux, pinconf and
interrupt functionalities documented since the binding should describe
what the hardware is capable of rather than what the driver offers.

This patchset has been tested on 96Boards MediatekX20 development board.

Thanks,
Mani

Changes in v3:

* Modified bindings doc according to Sean's suggestion.

Changes in v2:

* Added devicetree bindings for Pin Controller
* Dropped the applied warning fix patch
* Added Tested-by tag from Matthias Brugger
* Added Acked-by tag from Sean Wang

Manivannan Sadhasivam (4):
  dt-bindings: pinctrl: Add devicetree bindings for MT6797 SoC Pinctrl
  arm64: dts: mediatek: mt6797: Add pinctrl support
  arm64: dts: mediatek: x20: Add pinmux support for UART1
  pinctrl: mediatek: Add initial pinctrl driver for MT6797 SoC

 .../bindings/pinctrl/pinctrl-mt6797.txt       |   83 +
 .../boot/dts/mediatek/mt6797-x20-dev.dts      |    2 +
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   21 +
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6797.c     |   82 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h | 2430 +++++++++++++++++
 include/dt-bindings/pinctrl/mt6797-pinfunc.h  | 1368 ++++++++++
 8 files changed, 3994 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6797.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
 create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h

-- 
2.17.1
