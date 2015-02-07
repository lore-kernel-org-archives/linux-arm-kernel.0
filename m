From: cbz@baozis.org (Chen Baozi)
Date: Sat,  7 Feb 2015 13:07:13 +0800
Subject: [PATCH 0/3] Add support for Phytium FT-1500A SoC
Message-ID: <1423285636-8623-1-git-send-email-cbz@baozis.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset introduces support for Phytium FT-1500A SoC.

FT-1500A is the first arm64 SoC designed by Phytium, which includes
16 cores of armv8 processor, a 32-lane PCI-E host, 2 GMAC on-chip
ethernet controller and a GICv3 interrupt controller with ITS
support.

Chen Baozi (3):
  arm64: Add Kconfig option for Phytium FT SoC Family.
  arm64, ft-1500a: Add initial dts for Phytium FT-1500A SoC
  stmmac: Add AXI burst length support to platform device.

 Documentation/devicetree/bindings/net/stmmac.txt   |   1 +
 arch/arm64/Kconfig                                 |   5 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/phytium/Makefile               |   5 +
 arch/arm64/boot/dts/phytium/ft-1500a.dtsi          | 269 +++++++++++++++++++++
 arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts  |  39 +++
 arch/arm64/configs/defconfig                       |   2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   1 +
 8 files changed, 323 insertions(+)
 create mode 100644 arch/arm64/boot/dts/phytium/Makefile
 create mode 100644 arch/arm64/boot/dts/phytium/ft-1500a.dtsi
 create mode 100644 arch/arm64/boot/dts/phytium/ft1500a-v2-dsk-v2.dts

-- 
2.1.4
