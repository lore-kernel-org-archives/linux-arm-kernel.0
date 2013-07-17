From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 17 Jul 2013 18:10:19 -0500
Subject: [PATCH 0/4] Enable ethernet support for SOCFPGA
Message-ID: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hello,

These 4 patches are meant to enable ethernet and SD/MMC for the SOCFPGA
platform.

patch (1/4): Adds select ARM_TWD for the platform
patch (2/4): Add platform specific initialization for the ethernet controller.
patch (3/4): Commit 25c83b5c2 added "snps,phy-addr" for getting the PHY addr.
        Set the ethernet clocks to be emac_0_clk and emac_1_clk so it be gated.
patch (4/4): Update defconfig to support SD/MMC, ethernet, EXT3 and NFS.

Thanks,

Dinh Nguyen (4):
  arm: socfpga: Enable ARM_TWD for socfpga
  arm: socfpga: Add platform initialization for ethernet
  ARM: socfpga: dts: Fix entries for the ethernet entries.
  arm: socfpga: Add support for SD/MMC and ethernet to defconfig

 arch/arm/boot/dts/socfpga.dtsi         |    4 +-
 arch/arm/boot/dts/socfpga_cyclone5.dts |    2 +-
 arch/arm/configs/socfpga_defconfig     |    8 +++
 arch/arm/mach-socfpga/Kconfig          |    1 +
 arch/arm/mach-socfpga/core.h           |    8 +++
 arch/arm/mach-socfpga/socfpga.c        |   85 +++++++++++++++++++++++++++++++-
 6 files changed, 104 insertions(+), 4 deletions(-)

CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Jack Mitchell <jack.mitchell@dbbroadcast.co.uk>

-- 
1.7.9.5
