From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Tue, 11 Nov 2014 17:32:09 +0000
Subject: [PATCH v3 0/2] arm64: Add support for Juno development board
Message-ID: <1415727131-4572-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset adds device tree support for ARM's AArch64 Juno development
board. It enables use of various peripherals on the board, from USB and
networking to I2C and PL011 UART.

The patches can also be found in the repository at:

   git://github.com/ARM-software/linux.git juno/dts-for-armsoc

for you to fetch.


Changes vs v2:
  - rebased on top of arm-soc/next/cleanup
  - Split the flat device tree into several files. Although some
    commonality still remains in the main .dts file with other
    devices trees (see psci node) it is not clear what benefits can
    be gained from moving such a small node into its own file.
  - Ordered nodes according to their address space
  - Removed ulpi_phy node as it was redundant and the bindings non-standard.

v2 version: http://lkml.org/lkml/2014/11/10/242

Best regards,
Liviu

Liviu Dudau (2):
  arm64: Create link to include/dt-bindings to enable C preprocessor
    use.
  arm64: Add Juno board device tree.

 arch/arm64/boot/dts/arm/Makefile              |   1 +
 arch/arm64/boot/dts/arm/juno-clocks.dtsi      |  45 ++++++
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 129 +++++++++++++++
 arch/arm64/boot/dts/arm/juno.dts              | 218 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/include/dt-bindings       |   1 +
 5 files changed, 394 insertions(+)
 create mode 100644 arch/arm64/boot/dts/arm/juno-clocks.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/juno-motherboard.dtsi
 create mode 100644 arch/arm64/boot/dts/arm/juno.dts
 create mode 120000 arch/arm64/boot/dts/include/dt-bindings

-- 
2.1.3
