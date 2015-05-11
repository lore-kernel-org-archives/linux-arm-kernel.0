From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 11 May 2015 14:12:08 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.2
Message-ID: <1431371529-22593-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these patches for v4.2.

Thanks,
Dinh

The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  git://git.kernel.org:pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.2

for you to fetch changes up to da29d824a6709116dd4dc50b82400547447a4f53:

  ARM: socfpga: dts: add clocks to the Arria10 platform (2015-05-11 13:26:02 -0500)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.2
- Add accelerometer to sockit
- Update and clean up support for the Arria10 platform
- Add sdmmc_clk/4 clock node SoCFPGA Cyclone5/Arria5
- Update ethernet nodes with multicast/unicast/fifo-depth properties
- Add clocks for Arria10 platform

----------------------------------------------------------------
Dinh Nguyen (6):
      ARM: socfpga: dts: add cpu1-start-addr for Arria 10
      ARM: socfpga: dts: disable the sdmmc, and uart nodes in the base arria10
      ARM: socfpga: dts: enable UART1 for the debug uart
      ARM: socfpga: dts: rename socdk board file to socdk_sdmmc
      ARM: socfpga: dts: Add a clock node for sdmmc CIU
      ARM: socfpga: dts: add clocks to the Arria10 platform

Vince Bridgers (2):
      ARM: socfpga: dts: Add multicast bins and unicast filter entries
      ARM: socfpga: dts: Add tx-fifo-depth and rx-fifo-depth properties

Walter Lozano (1):
      ARM: socfpga: dts: Add adxl34x

 arch/arm/boot/dts/Makefile                         |   2 +-
 arch/arm/boot/dts/socfpga.dtsi                     |  14 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             | 335 ++++++++++++++++++++-
 ...rria10_socdk.dts => socfpga_arria10_socdk.dtsi} |  12 +-
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts  |  26 ++
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |  16 +
 6 files changed, 380 insertions(+), 25 deletions(-)
 rename arch/arm/boot/dts/{socfpga_arria10_socdk.dts => socfpga_arria10_socdk.dtsi} (90%)
 mode change 100755 => 100644
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
