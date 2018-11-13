From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Tue, 13 Nov 2018 10:06:10 -0600
Subject: [RESEND 0/4] Add SOCFPGA System Manager
Message-ID: <1542125174-8204-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add MFD driver for ARM64 SOCFPGA System Manager to steer
System Manager calls appropriately.
The SOCFPGA System Manager includes registers from several
SOC peripherals.

On ARM32, syscon handles this aggregated register grouping.
Redirect System Manager calls to syscon for ARM32 SOCFPGA
systems.

The ARM64 System Manager can only be accessed from priority
level EL3 so this new MFD driver handles the calls to EL3.

Thor Thayer (4):
  mfd: altera-sysmgr: Add SOCFPGA System Manager abstraction
  ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
  arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
  net: stmmac: socfpga: Convert to shared System Manager driver

 MAINTAINERS                                        |   6 +
 arch/arm/configs/socfpga_defconfig                 |   1 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/altera-sysmgr.c                        | 311 +++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   4 +-
 include/linux/mfd/altera-sysmgr.h                  | 113 ++++++++
 8 files changed, 445 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mfd/altera-sysmgr.c
 create mode 100644 include/linux/mfd/altera-sysmgr.h

-- 
2.7.4
