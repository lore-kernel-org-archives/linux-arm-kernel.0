From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Jan 2015 15:24:18 +0000
Subject: [PATCH v4 00/10] mtd: st_spi_fsm: Align with ST's internal development
Message-ID: <1421853868-8262-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian, all,
  
 [x] Bulid test
 [x] Bisectable
 [x] Smatch
 [x] Sparse

v4:
  Fully deprecated/removed the old all encompassing compatible string.
  Perfectly reasonable considering this driver is not in use by anyone
  and therefore the binding is not yet considered ABI.  There are also
  some checkpatch warning fixes in the "tidy-up" patch.  All patches
  have been rebased onto l2-mtd.git, as requested.
  
v3:
  Further aligned with upstream changes as suggested by Peter Griffin.
  The clk_ignore_unused kernel command line parameter is due to be turned
  off on STiH4* platforms, so we no longer give the driver the chance to
  opt-out of fetching the EMI clock.  We also now provide syscfg offsets
  inside the driver, as it's simpler and reduces the cost of having lots
  of extra DT properties.
  
v2:
  These are the last remaining patches in the set, all rebased and
  with the DT documentation requested after the last submission.
  
v1:
  This patch-set updates ST's FSM SPI-NOR driver with all the internal
  goodness which has happened since the initial (now upstreamed) snapshot
  was taken. It covers just over 6 months worth of internal development
  and bug-fixes. A final whitespace clean-up is also appended to the set
  - to make it look pretty and stuff. :)

Angus Clark (3):
  mtd: st_spi_fsm: Add support for N25Q512 and N25Q00A devices
  mtd: st_spi_fsm: Update Spansion device entries
  mtd: st_spi_fsm: Improve busy wait handling

Lee Jones (6):
  mtd: st_spi_fsm: dt-bindings: Deprecate generic compatible string
  mtd: st_spi_fsm: Fetch boot device locations from DT match tables
  mtd: st_spi_fsm: Update the JEDEC probe to handle extended READIDs
  mtd: st_spi_fsm: General tidy-up
  ARM: STi: stih416: Use new platform specific compatible string
  ARM: STi: stih416: Supply EMI clock reference to FSM SPI NOR

Nunzio Raciti (1):
  mtd: st_spi_fsm: Add support for Micron N25Q512A

 Documentation/devicetree/bindings/mtd/st-fsm.txt |  19 +-
 arch/arm/boot/dts/stih416.dtsi                   |   6 +-
 drivers/mtd/devices/st_spi_fsm.c                 | 627 ++++++++++++++---------
 include/dt-bindings/clock/stih416-clks.h         |   1 +
 4 files changed, 408 insertions(+), 245 deletions(-)

-- 
1.9.1
