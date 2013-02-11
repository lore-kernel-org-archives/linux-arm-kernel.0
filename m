From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 11 Feb 2013 17:30:29 -0600
Subject: [PATCHv5 for soc 0/4] Enabling socfpga on hardware 
Message-ID: <1360625433-28067-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

V5:
- Renamed v7_secondary_startup to socfpga_secondary_startup to avoid
a namespace conflict with imx for multiplatform

V4:
- Check for cpu1start_addr is valid in socfpga_boot_secondary()
- Add Reviewed-by: Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com> for 3/4

V3:
- Addressed comments from Olof Johansson and Russell King
- Received Acked-by and Tested-by Stephen Warren
- Received Signed-off-by Pavel Machek

V2:
- Remove patch that adds clock entries in the socfpga.dtsi as this
should accompany a rework in drivers/clk and will done in a different
patch series.
- Removed I-cache invalidate from v7_invalidate_l1
- Defined cpu1-start-addr as a device tree entry
- Removed the need to use CONFIG_VMSPLIT_2G


Dinh Nguyen (4):
  arm: socfpga: Add new device tree source for actual socfpga HW
  arm: socfpga: Add entries to enable make dtbs socfpga
  arm: Add v7_invalidate_l1 to cache-v7.S
  arm: socfpga: Add SMP support for actual socfpga harware

 .../bindings/arm/altera/socfpga-system.txt         |    2 +
 arch/arm/boot/dts/Makefile                         |    2 +
 arch/arm/boot/dts/socfpga.dtsi                     |   22 +++----
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   34 ++++++++++-
 arch/arm/boot/dts/socfpga_vt.dts                   |   64 ++++++++++++++++++++
 arch/arm/mach-imx/headsmp.S                        |   47 --------------
 arch/arm/mach-shmobile/headsmp.S                   |   48 ---------------
 arch/arm/mach-socfpga/core.h                       |    4 +-
 arch/arm/mach-socfpga/headsmp.S                    |   16 +++--
 arch/arm/mach-socfpga/platsmp.c                    |   17 +++---
 arch/arm/mach-socfpga/socfpga.c                    |    7 ++-
 arch/arm/mach-tegra/headsmp.S                      |   43 -------------
 arch/arm/mm/cache-v7.S                             |   46 ++++++++++++++
 13 files changed, 187 insertions(+), 165 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_vt.dts

-- 
1.7.9.5
