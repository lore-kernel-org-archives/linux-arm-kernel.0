From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 11 Apr 2016 15:02:46 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.7
Message-ID: <1460404966-3636-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

Please pull in these DTS updates for v4.7.

Thanks,
Dinh

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git socfpga_dts_for_v4.7

for you to fetch changes up to 249ff32e1f8b6ffa92e1390e371702dd8633bcac:

  ARM: dts: socfpga: add reset control for USB (2016-04-11 14:04:06 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.7
- Update SD/MMC node for Arria10
- Update Arria10 with clock and interrupt fields for DMA
- Remove 'phy-addr' from stmmac node
- Remove ethernet node from Cyclone5 DTSI
- Add LEDs/KEYs/SWs support on Sockit
- Add L2 and OCRAM EDAC dts entries
- Add reset control for USB

----------------------------------------------------------------
Dinh Nguyen (3):
      ARM: dts: socfpga: add cap-sd-highspeed for SD/MMC node
      ARM: dts: socfpga: add the clk-phase property for sd/mmc clock
      ARM: dts: socfpga: add reset control for USB

Graham Moore (1):
      ARM: dts: socfpga: Add missing clock and interrupt fields for Arria10 DMA

Marek Vasut (4):
      ARM: dts: socfpga: Drop phy-addr OF property from CV dtsi
      ARM: dts: socfpga: Drop gmac0 from CV dtsi
      ARM: dts: socfpga: Add support for HPS LEDs on SoCKit
      ARM: dts: socfpga: Add support for HPS KEYs/SWs on SoCKit

Thor Thayer (2):
      ARM: dts: socfpga: Add Altera Arria10 L2 Cache EDAC devicetree entry
      ARM: dts: socfpga: Add Altera Arria10 OCRAM EDAC devicetree entry

 arch/arm/boot/dts/socfpga.dtsi                    |  4 +
 arch/arm/boot/dts/socfpga_arria10.dtsi            | 32 +++++++-
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts |  1 +
 arch/arm/boot/dts/socfpga_cyclone5.dtsi           |  6 --
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts     | 94 ++++++++++++++++++++++-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts   |  1 +
 6 files changed, 129 insertions(+), 9 deletions(-)
