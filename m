From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat,  2 Jun 2018 22:24:12 +0530
Subject: [PATCH 0/3] Add gpio interrupt support for Actions Semi S900 SoC
Message-ID: <20180602165415.30956-1-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds interrupt support for Actions Semi S900 GPIO's. Each
port has individual register sets for configuring the below interrupt
types:

1. Rising Edge Interrupt
2. Falling Edge Interrupt
3. High Level Interrupt
4. Low Level Interrupt

Thanks,
Mani

Manivannan Sadhasivam (3):
  dt-bindings: pinctrl: Add gpio interrupt bindings for Actions S900 SoC
  arm64: dts: actions: Add interrupt properties to pinctrl node for S900
  pinctrl: actions: Add interrupt support for OWL S900 SoC

 .../bindings/pinctrl/actions,s900-pinctrl.txt |  10 +
 arch/arm64/boot/dts/actions/s900.dtsi         |   8 +
 drivers/pinctrl/actions/Kconfig               |   1 +
 drivers/pinctrl/actions/pinctrl-owl.c         | 231 +++++++++++++++++-
 drivers/pinctrl/actions/pinctrl-owl.h         |  22 +-
 drivers/pinctrl/actions/pinctrl-s900.c        |  31 ++-
 6 files changed, 285 insertions(+), 18 deletions(-)

-- 
2.17.0
