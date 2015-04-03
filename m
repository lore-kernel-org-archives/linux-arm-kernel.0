From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 2 Apr 2015 23:39:51 -0500
Subject: [PATCH 0/7] ARM: socfpga: Add support for Arria10 devkit
Message-ID: <1428035998-27542-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Hi,

This patchset enables and tidy up support for the Arria10 devkit. Along with
this patchset and the patch for enabling clocks on the Arria10, the devkit
can boot Linux.

Dinh Nguyen (7):
  ARM: socfpga: add cpu1-start-addr for Arria 10
  ARM: socfpga: disable the sdmmc, and uart nodes in the base arria10
  ARM: socfpga: dts: enable UART1 for the debug uart
  ARM: socfpga: rename socdk board file to socdk_sdmmc
  ARM: socfpga: Add support for UART1 debug uart for earlyprintk
  ARM: socfpga: remove the need to map uart_io_desc
  Documentation: DT bindings: add doc for Altera's SoCFPGA platform

 Documentation/devicetree/bindings/arm/altera.txt   | 14 ++++++++++++
 arch/arm/Kconfig.debug                             | 25 +++++++++++++++------
 arch/arm/boot/dts/Makefile                         |  2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |  4 ++++
 ...rria10_socdk.dts => socfpga_arria10_socdk.dtsi} |  6 ++---
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts  | 26 ++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c                    |  9 --------
 7 files changed, 65 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/altera.txt
 rename arch/arm/boot/dts/{socfpga_arria10_socdk.dts => socfpga_arria10_socdk.dtsi} (92%)
 mode change 100755 => 100644
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts

-- 
2.2.1
