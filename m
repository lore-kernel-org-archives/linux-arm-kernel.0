From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Thu, 16 Jul 2015 20:43:18 +0530
Subject: [PATCH v2 0/4]  Add support for touchscreen on Colibri VF50
Message-ID: <cover.1437058481.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The patchset adds support for 4 wire touchscreen on Toradex Colibri
VF50 modules. Patches are based on top of shawn's branch.

Changes since v1:
1. Fix/drop comments
2. Use an inline function for multiple gpiod_get calls in probe
3. Remove the pull up in the pinmux specified in DT for touchctrl_gpios
4. Add the io-channel-cells property before status property.
5. Add GPIOLIB as dependency in the Kconfig file

Version 1 of the patchset can be found here
https://lkml.org/lkml/2015/6/30/103

Thank you for the feedback Stefan.

Thanks & Regards,
Sanchayan.


Sanchayan Maity (4):
  ARM: dts: vfxxx: Add io-channel-cells property for ADC node
  ARM: dts: vf500-colibri: Add device tree node for touchscreen support
  touchscreen: colibri-vf50-ts: Add touchscreen support for Colibri VF50
  input: Add DT binding documentation for Colibri VF50 touchscreen

 .../bindings/input/touchscreen/colibri-vf50-ts.txt |  34 ++
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |   4 +
 arch/arm/boot/dts/vf500-colibri.dtsi               |  46 +++
 arch/arm/boot/dts/vfxxx.dtsi                       |   2 +
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/colibri-vf50-ts.c        | 451 +++++++++++++++++++++
 7 files changed, 550 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/colibri-vf50-ts.txt
 create mode 100644 drivers/input/touchscreen/colibri-vf50-ts.c

-- 
2.4.6
