From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 19 Aug 2015 10:36:59 +0200
Subject: [GIT PULL] Reset controller changes for v4.3
Message-ID: <1439973419.3160.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

This tag includes reset controller support for LPC18xx, SocFPGA Arria10,
AR71XX/AR9XXX and Zynq and moves all dt-bindings include files into the
same place.

regards
Philipp

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.3

for you to fetch changes up to 5d44595c2627f7edcd8c24a76b13bd115f9fc2da:

  Merge branch 'reset/ath79' into reset/next (2015-08-16 17:11:20 +0200)

----------------------------------------------------------------
Reset controller changes for v4.3

- moved the DT reset binding includes from
  include/dt-bindings/reset-controller to include/dt-bindings/reset
- new driver for LPC18xx Reset Generation Unit (RGU)
- of_device_id array in the STi driver changed to const.
- extend SoCFPGA reset driver to support Arria10
- new ath79 reset controller driver for AR71XX/AR9XXX
- new driver for Xilinx Zynq reset controller

----------------------------------------------------------------
Alban Bedel (3):
      devicetree: Add bindings for the ATH79 reset controller
      reset: Add a driver for the reset controller on the AR71XX/AR9XXX
      MIPS: ath79: Add the reset controller to the AR9132 dtsi

Dinh Nguyen (1):
      reset: socfpga: Update reset-socfpga to read the altr,modrst-offset property

Fabian Frederick (1):
      reset: sti: constify of_device_id array

Joachim Eastwood (2):
      reset: add driver for lpc18xx rgu
      doc: dt: add documentation for lpc1850-rgu reset driver

Moritz Fischer (2):
      docs: dts: Added documentation for Xilinx Zynq Reset Controller bindings.
      reset: reset-zynq: Adding support for Xilinx Zynq reset controller.

Philipp Zabel (3):
      MAINTAINERS: add include/dt-bindings/reset path to reset controller entry
      ARM: STi: DT: Move reset controller constants into common location
      Merge branch 'reset/ath79' into reset/next

 .../devicetree/bindings/reset/ath79-reset.txt      |  20 ++
 .../devicetree/bindings/reset/nxp,lpc1850-rgu.txt  |  84 +++++++
 .../bindings/reset/st,sti-picophyreset.txt         |   2 +-
 .../devicetree/bindings/reset/st,sti-powerdown.txt |   4 +-
 .../devicetree/bindings/reset/st,sti-softreset.txt |   4 +-
 .../devicetree/bindings/reset/zynq-reset.txt       |  68 ++++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih407-family.dtsi              |   2 +-
 arch/arm/boot/dts/stih415.dtsi                     |   2 +-
 arch/arm/boot/dts/stih416.dtsi                     |   2 +-
 arch/mips/Kconfig                                  |   1 +
 arch/mips/boot/dts/qca/ar9132.dtsi                 |   8 +
 drivers/reset/Makefile                             |   3 +
 drivers/reset/reset-ath79.c                        | 128 ++++++++++
 drivers/reset/reset-lpc18xx.c                      | 258 +++++++++++++++++++++
 drivers/reset/reset-socfpga.c                      |  19 +-
 drivers/reset/reset-zynq.c                         | 155 +++++++++++++
 drivers/reset/sti/reset-stih407.c                  |   4 +-
 drivers/reset/sti/reset-stih415.c                  |   4 +-
 drivers/reset/sti/reset-stih416.c                  |   4 +-
 .../{reset-controller => reset}/stih407-resets.h   |   0
 .../{reset-controller => reset}/stih415-resets.h   |   0
 .../{reset-controller => reset}/stih416-resets.h   |   0
 23 files changed, 753 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/ath79-reset.txt
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
 create mode 100644 Documentation/devicetree/bindings/reset/zynq-reset.txt
 create mode 100644 drivers/reset/reset-ath79.c
 create mode 100644 drivers/reset/reset-lpc18xx.c
 create mode 100644 drivers/reset/reset-zynq.c
 rename include/dt-bindings/{reset-controller => reset}/stih407-resets.h (100%)
 rename include/dt-bindings/{reset-controller => reset}/stih415-resets.h (100%)
 rename include/dt-bindings/{reset-controller => reset}/stih416-resets.h (100%)
