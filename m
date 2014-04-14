From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 14 Apr 2014 16:17:03 +0200
Subject: [GIT PULL] ARM: Updates for mmci driver for 3.16, take 1
Message-ID: <CAPDyKFp0K=cijuAZox7_BsTk2UCyC7Dp9HQoO6eJzaHikRMVUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I have collected some patches which all relates to changes to the mmci driver.

The SOC specific patches has been acked by the SOC maintainer Linus
Walleij and the DT patches has been iterated a few times, due to
comments from Rob Herring.

Unless you have some concern with any of the patches, please pull them
into your ARM tree.

Kind regards
Ulf Hansson


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ulf.hansson/linux-2.6.git
mmci_for_russell_3.16_take1

for you to fetch changes up to 724404ce84cbc3cb9a16dcc593bc4d07aa5b8b2e:

  mmc: mmci: Enforce max frequency configuration through DT
(2014-04-14 15:55:09 +0200)

----------------------------------------------------------------
Ulf Hansson (22):
      mmc: mmci: Mask IRQs for all variants during runtime suspend
      mmc: mmci: Let runtime PM callbacks be available for CONFIG_PM
      mmc: mmci: Put the device into low power state at system suspend
      mmc: mmci: Convert to the mmc gpio API
      mmc: mmci: Convert to devm functions
      mmc: mmci: Update DT documentation
      mmc: mmci: Add DT bindings for signal direction
      mmc: mmci: Add DT bindings for feedback clock pin
      mmc: mmci: Use the common mmc DT parser
      ARM: ux500: Add mmci signal directions and feeback clock in DT for href
      ARM: ux500: Convert to the common mmc DT bindings for highspeed mode
      ARM: nomadik: Convert to the common mmc DT bindings for highspeed mode
      ARM: u300: Convert to the common mmc DT bindings for highspeed mode
      mmc: mmci: Mark the DT bindings for highspeed mode as deprecated
      mmc: mmci: Enable MMC_CAP_CMD23
      ARM: ux500: Add the mmc capabilities flags to DT
      ARM: ux500: Add a vmmc regulator through DT for the poped eMMC for href
      ARM: ux500: Remove redundant board file for mmci platform data
      mmc: mmci: Enforce DT for signal direction and feedback clock
      mmc: mmci: Enforce mmc capabilities through DT
      mmc: mmci: Enforce DMA configuration through DT
      mmc: mmci: Enforce max frequency configuration through DT

 Documentation/devicetree/bindings/mmc/mmci.txt |   54 +++-
 arch/arm/boot/dts/ste-ccu9540.dts              |    6 +-
 arch/arm/boot/dts/ste-href.dtsi                |   19 +-
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi     |    4 +-
 arch/arm/boot/dts/ste-snowball.dts             |    4 +-
 arch/arm/boot/dts/ste-u300.dts                 |    4 +-
 arch/arm/mach-ux500/Makefile                   |    3 +-
 arch/arm/mach-ux500/board-mop500-sdi.c         |  166 ------------
 arch/arm/mach-ux500/board-mop500.h             |    5 -
 arch/arm/mach-ux500/cpu-db8500.c               |    4 -
 drivers/mmc/host/mmci.c                        |  324 ++++++------------------
 drivers/mmc/host/mmci.h                        |   14 +-
 include/linux/amba/mmci.h                      |   42 ---
 13 files changed, 169 insertions(+), 480 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/board-mop500-sdi.c
