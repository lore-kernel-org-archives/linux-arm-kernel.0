From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 26 Feb 2014 21:34:37 -0600
Subject: [GIT PULL] SOCFPGA updates for 3.15
Message-ID: <1393472077-16220-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these patches for v3.15.

Thanks,
Dinh

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_updates_for_3.15

for you to fetch changes up to 1b60b9fac9c56488f78aa4396301757d37e586e7:

  dts: socfpga: Update clock entry to support multiple parents (2014-02-26 21:12:51 -0600)

----------------------------------------------------------------
SOCFPGA updates for 3.15:
*Update SOCFPGA DTS to include ethernet, and clock fixes
*Add stmmac ethernet glue layer
*Update socfpga_defconfig to include sd/mmc, and micrel_phy

----------------------------------------------------------------
Dinh Nguyen (4):
      net: stmmac: Add SOCFPGA glue driver
      dts: socfpga: Add DTS entry for adding the stmmac glue layer for stmmac.
      ARM: socfpga: Update socfpga_defconfig
      dts: socfpga: Update clock entry to support multiple parents

 .../devicetree/bindings/net/socfpga-dwmac.txt      |   35 ++++
 arch/arm/boot/dts/socfpga.dtsi                     |   68 +++++---
 arch/arm/boot/dts/socfpga_arria5_socdk.dts         |   24 +++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |   17 ++
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |   22 ++-
 arch/arm/boot/dts/socfpga_vt.dts                   |    8 +
 arch/arm/configs/socfpga_defconfig                 |    6 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  183 ++++++++++++++++++++
 9 files changed, 342 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/socfpga-dwmac.txt
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
