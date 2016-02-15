From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Feb 2016 09:47:40 +0100
Subject: [PATCH 0/5] arm64: Initial support for Marvell Armada 7K/8K
Message-ID: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series adds initial support for the new Armada 7K and 8K Marvell
64 bits processors. Details about those processors based on the
Cortex-A72 can be found at:

  http://www.marvell.com/embedded-processors/armada-70xx/
  http://www.marvell.com/embedded-processors/armada-80xx/

One characteristic of those processors is that internally they are
built from several components:

 - One "AP", which contains the processor itself and a few core IP
   blocks. The AP in 7K and 8K is called AP806, and is available on
   two variants: dual Cortex-A72 and quad Cortex-A72.

 - Or or two "CP", which contains most of the I/Os (SATA, PCIe,
   etc.). The CP in 7K and 8K is called CP110. One CP110 is available
   in the 7K family, while two CP110 are available in the 8K family,
   doubling the number of I/O interfaces.

The support added in this series only brings minimal support for the
AP side (and not yet all IP blocks, obviously). Support for the CP
part will come in the future.

Since the series touches similar files as the Armada 3700 series from
Gregory Clement, it is based on it.

Best regards,

Thomas

Thomas Petazzoni (5):
  Documentation: arm: improve Armada 37xx description
  Documentation: arm: add Marvell Armada 7K and 8K families
  Documentation: arm: improve Marvell EBU Armada documentation
  arm64: update ARCH_MVEBU for Marvell Armada 7K/8K support
  arm64: marvell: add Device Tree files for Armada 7K/8K

 Documentation/arm/Marvell/README                   |  39 +++-
 .../bindings/arm/marvell/armada-7k-8k.txt          |  24 +++
 arch/arm64/Kconfig.platforms                       |  11 +-
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/armada-7020.dtsi       |  54 +++++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts     |  92 ++++++++
 arch/arm64/boot/dts/marvell/armada-7040.dtsi       |  54 +++++
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |  54 +++++
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |  54 +++++
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |  71 +++++++
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |  84 ++++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      | 235 +++++++++++++++++++++
 12 files changed, 762 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.txt
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7020.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7040-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7040.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8020.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap806.dtsi

-- 
2.6.4
