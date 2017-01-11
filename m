From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 11 Jan 2017 14:07:17 -0600
Subject: [GIT PULL 2/2] SoCFPGA DTS updates for v4.11, part 1
In-Reply-To: <1484165237-26640-1-git-send-email-dinguyen@kernel.org>
References: <1484165237-26640-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1484165237-26640-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in these DTS updates for v4.11.

Thanks,
Dinh

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.11_part_1

for you to fetch changes up to 7f0f5460d46867a8f980683136a054cff1357780:

  ARM: dts: socfpga: add missing compatible string for SDRAM controller (2017-01-06 01:42:06 -0600)

----------------------------------------------------------------
SoCFPGA DTS updates for v4.11, part 1
- Adds FPGA manager bits
- Enable I2C on Cyclone5 and Arria5 devkits
- Adds LED support on C5/A5 devkits
- Enables CAN on C5 devkit
- Enables watchdog
- Add NAND on Arria10
- Add the LTC2977 Power Monitor on Arria10 devkit

----------------------------------------------------------------
Alan Tull (1):
      ARM: dts: socfpga: add base fpga region and fpga bridges

Dinh Nguyen (10):
      ARM: dts: socfpga: enable GPIO and LEDs for Cyclone5 and Arria5 devkits
      ARM: dts: socfpga: set desired i2c clock on Cyclone5 and Arria5 devkits
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
 arch/arm/boot/dts/socfpga.dtsi                   | 31 +++++++++++++-
 arch/arm/boot/dts/socfpga_arria10.dtsi           | 32 +++++++++++++-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi     |  9 ++++
 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts | 31 ++++++++++++++
 arch/arm/boot/dts/socfpga_arria5.dtsi            |  4 ++
 arch/arm/boot/dts/socfpga_arria5_socdk.dts       | 43 +++++++++++++++++++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts     | 53 ++++++++++++++++++++++++
 8 files changed, 201 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
