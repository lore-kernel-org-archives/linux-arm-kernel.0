From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Nov 2013 22:45:28 +0800
Subject: [PATCH 0/5] ARM: dts: imx: make pinctrl nodes board specific
Message-ID: <1383576333-19113-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It creates <soc>-pingrp.h and move all those pinctrl setting data into
there as macro definitions.  The <board>.dts will instead define the
pinctrl setting nodes that are necessary for the board by referring to
the macros in <soc>-pingrp.h, so that only the pinctrl setting data that
will be used by the board will get compiled into the DTB for the board.

Shawn Guo (5):
  ARM: dts: imx6qdl: make pinctrl nodes board specific
  ARM: dts: imx6sl: make pinctrl nodes board specific
  ARM: dts: imx53: make pinctrl nodes board specific
  ARM: dts: imx51: make pinctrl nodes board specific
  ARM: dts: imx50: make pinctrl nodes board specific

 arch/arm/boot/dts/imx50-evk.dts                    |   22 +-
 arch/arm/boot/dts/imx50-pingrp.h                   |  144 ++++
 arch/arm/boot/dts/imx50.dtsi                       |  219 +-----
 arch/arm/boot/dts/imx51-apf51.dts                  |   16 +-
 arch/arm/boot/dts/imx51-apf51dev.dts               |   38 +-
 arch/arm/boot/dts/imx51-babbage.dts                |   82 +-
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi       |   14 +-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |   38 +-
 arch/arm/boot/dts/imx51-pingrp.h                   |  247 ++++++
 arch/arm/boot/dts/imx51.dtsi                       |  343 +--------
 arch/arm/boot/dts/imx53-ard.dts                    |   14 +-
 arch/arm/boot/dts/imx53-evk.dts                    |   38 +-
 arch/arm/boot/dts/imx53-m53evk.dts                 |   86 ++-
 arch/arm/boot/dts/imx53-mba53.dts                  |    2 +-
 arch/arm/boot/dts/imx53-pingrp.h                   |  350 +++++++++
 arch/arm/boot/dts/imx53-qsb.dts                    |   51 +-
 arch/arm/boot/dts/imx53-smd.dts                    |   62 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |  107 ++-
 arch/arm/boot/dts/imx53-voipac-bsb.dts             |   25 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        |   26 +-
 arch/arm/boot/dts/imx53.dtsi                       |  516 +------------
 arch/arm/boot/dts/imx6dl.dtsi                      |    1 +
 arch/arm/boot/dts/imx6q-arm2.dts                   |   50 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |   22 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   68 +-
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi         |   44 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |   50 +-
 arch/arm/boot/dts/imx6q-sbc6x.dts                  |   29 +-
 arch/arm/boot/dts/imx6q-udoo.dts                   |   16 +-
 arch/arm/boot/dts/imx6q.dtsi                       |    1 +
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi              |   62 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   68 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   74 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   74 +-
 arch/arm/boot/dts/imx6qdl-pingrp.h                 |  542 +++++++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   58 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   62 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   62 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  798 --------------------
 arch/arm/boot/dts/imx6sl-evk.dts                   |   80 +-
 arch/arm/boot/dts/imx6sl-pingrp.h                  |  144 ++++
 arch/arm/boot/dts/imx6sl.dtsi                      |  214 +-----
 42 files changed, 2588 insertions(+), 2371 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx50-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx51-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx53-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx6qdl-pingrp.h
 create mode 100644 arch/arm/boot/dts/imx6sl-pingrp.h

-- 
1.7.9.5
