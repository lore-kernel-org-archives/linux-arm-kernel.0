From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  3 Mar 2015 10:32:23 +0100
Subject: [PATCH 0/5] simple-mfd and syscon LEDs
Message-ID: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements a suggestion from Lee Jones on how to
resolve the dilemma with subnodes under syscons that do things like
the simple syscon LEDs.

Please see the bigger picture, this is not about LEDs only but any
simple subnodes under an MFD.

Linus Walleij (5):
  MFD/OF: document MFD devices and handle simple-mfd
  ARM: dts: update syscons to use simple-mfd
  leds: syscon: instantiate from platform device
  arm64: juno: Add APB registers and LEDs using syscon
  arm64: add LEDs and some trigger support to defconfig

 Documentation/devicetree/bindings/mfd/mfd.txt |  40 ++++++
 arch/arm/boot/dts/arm-realview-pb1176.dts     |   2 +-
 arch/arm/boot/dts/integrator.dtsi             |   4 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi |  68 +++++++++++
 arch/arm64/configs/defconfig                  |   6 +
 drivers/leds/leds-syscon.c                    | 170 +++++++++++++-------------
 drivers/of/platform.c                         |   1 +
 7 files changed, 203 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mfd.txt

-- 
1.9.3
