From: carlo@caione.org (Carlo Caione)
Date: Mon,  2 May 2016 10:02:14 +0200
Subject: [PATCH v2 0/4] Amlogic: GXBB: Add pin controller
Message-ID: <1462176138-29433-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Patchset to add and enable the pin controller driver on a couple of Amlogic
boards with a Meson GXBB SoC.

Please note that:
* This patch depends on http://www.spinics.net/lists/devicetree/msg120964.html
  ([PATCH] ARM64: dts: amlogic: Add hiu and periphs buses).

* The platform driver is still missing a lot of muxing configurations. This is
  because Amlogic still hasn't publicly released documentation for the GXBB.
  Since Kevin has already this documentation under NDA, he will integrate and
  complete this driver with a separate submission.

Changelog:
* v2:
  - Split patchset in 4 different patches

Carlo Caione (4):
  pinctrl: amlogic: Add support for Amlogic Meson GXBB SoC
  documentation: Add compatibles for Amlogic Meson GXBB pin controllers
  ARM64: Kconfig: Select the Amlogic Meson pin controller driver
  ARM64: dts: amlogic: Enable pin controller on GXBB-based platforms

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   2 +
 arch/arm64/Kconfig.platforms                       |   2 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  13 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |   2 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |   3 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  41 ++
 drivers/pinctrl/meson/Makefile                     |   2 +-
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c         | 432 +++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.c              |   8 +
 drivers/pinctrl/meson/pinctrl-meson.h              |   2 +
 include/dt-bindings/gpio/meson-gxbb-gpio.h         | 154 ++++++++
 11 files changed, 660 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-gxbb.c
 create mode 100644 include/dt-bindings/gpio/meson-gxbb-gpio.h

-- 
2.7.4
