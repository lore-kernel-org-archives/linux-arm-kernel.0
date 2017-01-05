From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed,  4 Jan 2017 18:21:22 -0600
Subject: [PATCH 00/12] ARM: dts: socfpga: enable a few hardware bits
Message-ID: <1483575694-29599-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a few DTS updates for SoCFPGA platforms, such as:

- Adds FPGA manager bits
- Enable I2C on Cyclone5 and Arria5 devkits
- Adds LED support on C5/A5 devkits
- Enables CAN on C5 devkit
- Enables watchdog
- Add NAND on Arria10
- Add the LTC2977 Power Monitor on Arria10 devkit

Thanks,
Dinh

Alan Tull (1):
  ARM: dts: socfpga: add base fpga region and fpga bridges

Dinh Nguyen (10):
  ARM: dts: socfpga: enable GPIO and LEDs for Cyclone5 and Arria5
    devkits
  ARM: dts: socfpga: set desired i2c clock on Cyclone5 and Arria5
    devkits
  ARM: dts: socfpga: Add Rohm DH2228FV DAC
  ARM: dts: socfpga: enable CAN on Cyclone5 devkit
  ARM: dts: socfpga: enable watchdog timer on Arria5 and Arria10
  ARM: dts: socfpga: add the LTC2977 power monitor on Arria10 devkit
  ARM: dts: socfpga: add fpga-manager node for Arria10
  ARM: dts: socfpga: fpga manager data is 32 bits
  ARM: dts: socfpga: add fpga region support on Arria10
  ARM: dts: socfpga: add missing compatible string for SDRAM controller

Graham Moore (1):
  ARM: dts: socfpga: Add NAND device tree for Arria10

 arch/arm/boot/dts/Makefile                       |  1 +
 arch/arm/boot/dts/socfpga.dtsi                   | 35 +++++++++++++++-
 arch/arm/boot/dts/socfpga_arria10.dtsi           | 19 ++++++++-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi     |  9 ++++
 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts | 44 ++++++++++++++++++++
 arch/arm/boot/dts/socfpga_arria5.dtsi            |  4 ++
 arch/arm/boot/dts/socfpga_arria5_socdk.dts       | 43 +++++++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts     | 53 ++++++++++++++++++++++++
 8 files changed, 205 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts

-- 
2.7.4
