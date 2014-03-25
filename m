From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 25 Mar 2014 18:34:39 -0500
Subject: [PATCH 0/3] Fix stmmac-socfpga allmodconfig breakage in arm-soc
Message-ID: <1395790482-3957-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Hi,

These 3 patches are based on Arnd's patch to fix the allmodconfig for the
dwmac-socfpga implementation. I just broke the patch out into drivers,
dts, and dts documentation.

The original patch is here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241518.html

Arnd mentioned that he was thinking about just removing the dwmac-socfpga
and send out the new verion to the netdev tree, but I haven't seen it. So
just in case this solution might work, here are the patches.

These patches are based on arm-soc/for-next.

Thanks,

Dinh Nguyen (3):
  net: stmmac: improve binding and fix build
  dts: socfpga: Fix ethernet entries for the stmmac
  dts: documentation: Update documentation for the stmmac ethernet
    controller

 .../devicetree/bindings/net/socfpga-dwmac.txt      |   38 ++++------
 Documentation/devicetree/bindings/net/stmmac.txt   |    6 ++
 arch/arm/boot/dts/socfpga.dtsi                     |   51 +++++---------
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |    5 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |    5 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |    5 +-
 arch/arm/boot/dts/socfpga_vt.dts                   |    5 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |   10 +++
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   73 +++-----------------
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |    1 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    3 +
 12 files changed, 67 insertions(+), 137 deletions(-)

-- 
1.7.9.5
