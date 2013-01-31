From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 31 Jan 2013 11:05:39 -0600
Subject: [PATCHv2 for soc 0/4] Enabling socfpga on hardware
Message-ID: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

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
 arch/arm/mach-socfpga/platsmp.c                    |    3 +-
 arch/arm/mach-socfpga/socfpga.c                    |    9 +++
 arch/arm/mach-tegra/headsmp.S                      |   43 -------------
 arch/arm/mm/cache-v7.S                             |   46 ++++++++++++++
 13 files changed, 182 insertions(+), 158 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_vt.dts

-- 
1.7.9.5
