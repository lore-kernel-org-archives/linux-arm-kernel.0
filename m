From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Aug 2011 14:52:21 +0800
Subject: [PATCH v4 0/2] Add device tree support for i.mx51/53 boards
Message-ID: <1312267943-25551-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v3:
 * Fix machine_desc table for ARD matching
 * Turn the board setup that dt needs into callback

Changes since v2:
 * Drop iomuxc device tree support patch

Changes since v1:
 * Address comments on v1 given by Grant and Sascha
 * Add i.mx51 Babbage support

Shawn Guo (2):
      arm/mx5: add device tree support for imx53 boards
      arm/mx5: add device tree support for imx51 babbage

 .../devicetree/bindings/arm/fsl/boards.txt         |   19 ++
 arch/arm/boot/dts/imx51-babbage.dts                |  141 +++++++++++
 arch/arm/boot/dts/imx51.dtsi                       |  203 ++++++++++++++++
 arch/arm/boot/dts/imx53-ard.dts                    |  158 +++++++++++++
 arch/arm/boot/dts/imx53-evk.dts                    |  144 ++++++++++++
 arch/arm/boot/dts/imx53-qsb.dts                    |  148 ++++++++++++
 arch/arm/boot/dts/imx53-smd.dts                    |  169 ++++++++++++++
 arch/arm/boot/dts/imx53.dtsi                       |  244 ++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                          |   21 ++
 arch/arm/mach-mx5/Makefile                         |    3 +
 arch/arm/mach-mx5/board-mx51_babbage.c             |    9 +-
 arch/arm/mach-mx5/board-mx53_ard.c                 |   12 +-
 arch/arm/mach-mx5/board-mx53_evk.c                 |    9 +-
 arch/arm/mach-mx5/board-mx53_loco.c                |    9 +-
 arch/arm/mach-mx5/board-mx53_smd.c                 |    9 +-
 arch/arm/mach-mx5/imx51-dt.c                       |  111 +++++++++
 arch/arm/mach-mx5/imx53-dt.c                       |  127 ++++++++++
 arch/arm/plat-mxc/include/mach/common.h            |    6 +
 18 files changed, 1530 insertions(+), 12 deletions(-)
