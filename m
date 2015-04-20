From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 20 Apr 2015 13:50:21 -0500
Subject: [PATCHv2 0/4] Add support for Arria10 devkit
Message-ID: <1429555825-23560-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Hi,

This patchset enables and tidy up support for the Arria10 devkit. Along with
this patchset and the patchset for enabling clocks on the Arria10, the devkit
can boot Linux.

V2:
- Patch "ARM: socfpga: dts: enable UART1 for the debug uart" adds the removal
  of unused aliases in the dts file.

- Split out the "Documentation: DT bindings: add doc for Altera's SoCFPGA
  platform" patch.

- Split out the 2 patches for early printk uart.

Thanks,

Dinh Nguyen (4):
  ARM: socfpga: add cpu1-start-addr for Arria 10
  ARM: socfpga: disable the sdmmc, and uart nodes in the base arria10
  ARM: socfpga: dts: enable UART1 for the debug uart
  ARM: socfpga: rename socdk board file to socdk_sdmmc

 arch/arm/boot/dts/Makefile                        |  2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi            | 16 ++------
 arch/arm/boot/dts/socfpga_arria10_socdk.dts       | 48 -----------------------
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi      | 46 ++++++++++++++++++++++
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts | 26 ++++++++++++
 5 files changed, 77 insertions(+), 61 deletions(-)
 delete mode 100755 arch/arm/boot/dts/socfpga_arria10_socdk.dts
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts

-- 
2.2.1
