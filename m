From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:13:57 +0100
Subject: [PATCH 00/20] mmc: mmci: Improve DT support
Message-ID: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Step by step, improve the DT support for the mmci host driver.

This enables us to move the final pieces of platform data for mmci for ux500
into DT. We are then able to remove yet another machine specific file for ux500.

This patchset needs to be merged together. I suggest we go through Russell's
ARM tree, since most of the patches are mmci specific which he maintains -
unless someone think there is a better alternative.

I will thus seek acks from the SOC maintainers as well as the regulator
maintainers. Note, one minor patch was needed for a specific regulator used by
ux500, I assumes it will be a trivial patch to ack, but let's see. :-)

The goal is to queue this for 3.16, thus I might need to rebase the patches for
3.15 rc[n]. Still I would appreciate any comments at this point.


Ulf Hansson (20):
  mmc: mmci: Convert to the mmc gpio API
  mmc: mmci: Convert to devm functions
  mmc: mmci: Update DT documentation
  mmc: mmci: Move signal directions bits into DT include file
  mmc: mmci: Add DT bindings for signal direction
  mmc: mmci: Use the common mmc DT parser
  ARM: ux500: Add mmci signal directions in DT for href
  ARM: ux500: Convert to the common mmc DT bindings for highspeed mode
  ARM: nomadik: Convert to the common mmc DT bindings for highspeed
    mode
  ARM: u300: Convert to the common mmc DT bindings for highspeed mode
  mmc: mmci: Mark the DT bindings for highspeed mode as deprecated
  mmc: mmci: Enable MMC_CAP_CMD23
  ARM: ux500: Add the mmc capabilities flags to DT
  regulator: db8500-prcmu: Set 1.8V as a fixed voltage for vsmps2
  ARM: ux500: Add a vmmc regulator through DT for the poped eMMC for
    href
  ARM: ux500: Remove redundant board file for mmci platform data
  mmc: mmci: Enforce DT for signal direction
  mmc: mmci: Enforce mmc capabilities through DT
  mmc: mmci: Enforce DMA configuration through DT
  mmc: mmci: Enforce max frequency configuration through DT

 Documentation/devicetree/bindings/mmc/mmci.txt |   41 +++-
 arch/arm/boot/dts/ste-ccu9540.dts              |    6 +-
 arch/arm/boot/dts/ste-href.dtsi                |   20 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi     |    4 +-
 arch/arm/boot/dts/ste-snowball.dts             |    4 +-
 arch/arm/boot/dts/ste-u300.dts                 |    4 +-
 arch/arm/mach-ux500/Makefile                   |    3 +-
 arch/arm/mach-ux500/board-mop500-sdi.c         |  166 ---------------
 arch/arm/mach-ux500/board-mop500.h             |    5 -
 arch/arm/mach-ux500/cpu-db8500.c               |    4 -
 drivers/mmc/host/mmci.c                        |  259 ++++++------------------
 drivers/mmc/host/mmci.h                        |    4 +-
 drivers/regulator/db8500-prcmu.c               |    2 +
 include/dt-bindings/mmc/mmci.h                 |   21 ++
 include/linux/amba/mmci.h                      |   42 ----
 15 files changed, 153 insertions(+), 432 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-mop500-sdi.c
 create mode 100644 include/dt-bindings/mmc/mmci.h

-- 
1.7.9.5
