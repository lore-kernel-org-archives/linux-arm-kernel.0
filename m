From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Aug 2011 03:17:30 +0800
Subject: [PATCH v3 0/3] Add device tree support for i.mx51/53 boards
Message-ID: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have not reached the agreement on iomuxc binding, I'm dropping
that patch and reusing the iomuxc setup that is currently used by non-dt
board files.  Hopefully, doing that could get the series merged for
v3.1, so that people can start playing device tree on i.mx51 babbage and
i.mx53 quick start board.

Will revisit the iomuxc device tree support, when we agree on the right
approach to do it.

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
 arch/arm/mach-mx5/board-mx51_babbage.c             |    5 +
 arch/arm/mach-mx5/board-mx53_ard.c                 |    9 +-
 arch/arm/mach-mx5/board-mx53_evk.c                 |    5 +
 arch/arm/mach-mx5/board-mx53_loco.c                |    5 +
 arch/arm/mach-mx5/board-mx53_smd.c                 |    5 +
 arch/arm/mach-mx5/imx51-dt.c                       |  112 +++++++++
 arch/arm/mach-mx5/imx53-dt.c                       |  143 ++++++++++++
 arch/arm/plat-mxc/include/mach/common.h            |    2 +
 arch/arm/plat-mxc/include/mach/iomux-mx51.h        |    2 +
 arch/arm/plat-mxc/include/mach/iomux-mx53.h        |    5 +
 arch/arm/plat-mxc/include/mach/iomux-v3.h          |    5 +
 21 files changed, 1546 insertions(+), 2 deletions(-)
