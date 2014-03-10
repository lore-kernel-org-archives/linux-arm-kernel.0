From: dinguyen@altera.com (dinguyen at altera.com)
Date: Sun, 9 Mar 2014 23:55:33 -0500
Subject: [GIT PULL v2] SOCFPGA updates for 3.15, version 2
Message-ID: <1394427333-9028-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these patches for v3.15 version 2. I apologize for
the build failure in version 1.

For this version, I also cherry-picked a commit that was also pulled into
Chris Ball's mmc tree.

9b931361ff09 dts: socfpga: Add support for SD/MMC on the SOCFPGA platform

Without this patch, I cannot cleanly fix the build error and avoid a merge
conflict.

[a5d6ac2a dts: socfpga: Add sysmgr node so the gmac can use to reference] will
fix the build failure in version 1.

Thanks, 

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_updates_for_3.15_v2

for you to fetch changes up to a5d6ac2a84a393a7142f9cafe15ade9aa94b6b42:

  dts: socfpga: Add sysmgr node so the gmac can use to reference (2014-03-09 23:21:52 -0500)

----------------------------------------------------------------
SOCFPGA updates for 3.15 version 2:
*Update SOCFPGA DTS to include ethernet, sd/mmc, and clock fixes
*Add stmmac ethernet glue layer
*Update socfpga_defconfig to include sd/mmc, and micrel_phy

----------------------------------------------------------------
Dinh Nguyen (6):
      net: stmmac: Add SOCFPGA glue driver
      dts: socfpga: Add DTS entry for adding the stmmac glue layer for stmmac.
      ARM: socfpga: Update socfpga_defconfig
      dts: socfpga: Update clock entry to support multiple parents
      dts: socfpga: Add support for SD/MMC on the SOCFPGA platform
      dts: socfpga: Add sysmgr node so the gmac can use to reference

 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   23 +++
 .../devicetree/bindings/net/socfpga-dwmac.txt      |   35 ++++
 arch/arm/boot/dts/socfpga.dtsi                     |   87 +++++++---
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   11 ++
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |   24 +++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |   11 ++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |   17 ++
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |   22 ++-
 arch/arm/boot/dts/socfpga_vt.dts                   |   19 ++
 arch/arm/configs/socfpga_defconfig                 |    6 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  183 ++++++++++++++++++++
 12 files changed, 413 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
 create mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
