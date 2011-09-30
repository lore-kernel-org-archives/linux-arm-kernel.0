From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Sep 2011 21:35:45 +0800
Subject: [PATCH v5 0/2] Add device tree support for i.mx51/53 boards
Message-ID: <1317389747-24589-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

This is an update of the patch series below, which had gone through the
review and almost hit the v3.1 (it missed the last pull request Arnd
sent to Linus just for one day or so).

  [PATCH v4 0/2] Add device tree support for i.mx51/53 boards
  http://thread.gmane.org/gmane.linux.drivers.devicetree/7048

I was planning to hold the series until we have a iomuxc binding to
totally remove the dependency on non-dt board files.  But as a cross
platform topic, it needs to take more time to get it settled down,
while I'm concerned by that people keep adding stuff into non-dt board
files with ignoring DT support.  I'm here to revisit the series and
trying to get it merged in the coming merge window, so that we have
a base to ask people to move to DT.

Changes since v4:
 * Rebase onto imx-features branch
 * Have devices in soc dtsi as "disabled" and explicitly enable the
   ones in board dts as "okay"
 * Utilize of_irq_init() infrastructure added by Rob Herring recently

Shawn Guo (2):
      arm/mx5: add device tree support for imx53 boards
      arm/mx5: add device tree support for imx51 babbage

 Documentation/devicetree/bindings/arm/fsl.txt |   19 ++
 arch/arm/boot/dts/imx51-babbage.dts           |  135 ++++++++++++
 arch/arm/boot/dts/imx51.dtsi                  |  221 ++++++++++++++++++++
 arch/arm/boot/dts/imx53-ard.dts               |  113 ++++++++++
 arch/arm/boot/dts/imx53-evk.dts               |  120 +++++++++++
 arch/arm/boot/dts/imx53-qsb.dts               |  125 +++++++++++
 arch/arm/boot/dts/imx53-smd.dts               |  169 +++++++++++++++
 arch/arm/boot/dts/imx53.dtsi                  |  276 +++++++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                     |   21 ++
 arch/arm/mach-mx5/Makefile                    |    3 +
 arch/arm/mach-mx5/board-mx51_babbage.c        |    9 +-
 arch/arm/mach-mx5/board-mx53_ard.c            |   12 +-
 arch/arm/mach-mx5/board-mx53_evk.c            |    9 +-
 arch/arm/mach-mx5/board-mx53_loco.c           |    9 +-
 arch/arm/mach-mx5/board-mx53_smd.c            |    9 +-
 arch/arm/mach-mx5/imx51-dt.c                  |  116 +++++++++++
 arch/arm/mach-mx5/imx53-dt.c                  |  126 +++++++++++
 arch/arm/plat-mxc/include/mach/common.h       |    5 +
 18 files changed, 1485 insertions(+), 12 deletions(-)
