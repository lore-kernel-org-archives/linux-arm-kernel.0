From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 24 Sep 2014 22:48:54 +0800
Subject: [PATCH v2 0/7] ARM: sunxi: Add basic support for Allwinner A80 SoC
Message-ID: <1411570141-29960-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of the initial Allwinner A80 support series.
This patch series adds very basic support for Allwinner's A80 SoC,
a big.LITTLE architecture with 4 Cortex-A7s and 4 Cortex-A15s.

Development is done on the A80 Optimus Board, the defacto development
board for the A80, with the accompanying SDK as a reference. 

So far I've been unable to get the board to boot from MMC, or
using Android fastboot. I'm using Allwinner's FEL mode to load
the bootloader and kernel+dtb image over USB. Notes on my attempts
can be found here: http://linux-sunxi.org/User:Wens#A80_Optimus


Patch 1 introduces the compatible string for the A80.

Patch 2 adds options to use UART0 on the A80 as the debug port for
earlyprintk.

Patch 3 adds a barebone dtsi with just the cpu, memory and uart nodes.

Patch 4 adds a barebone dts for the A80 Optimus Board.

Patch 5 documents the vendor prefix for Merrii Technology Co., Ltd,
the designer and vendor of the A80 Optimus Board.

Patch 6 documents all the Allwinner SoCs we currently support.

Patch 7 updates the sunxi README with a link to the A80's datasheet.


Changes since v1:

  - Use skeleton64.dtsi as basis to support maximum of 8GB DRAM
  - Dropped dependency on ARCH_SUNXI for DEBUG_SUN9I_UART0
  - Added empty lines separating cores in the DT cpu-map node
  - Added patch 7 to update sunxi README

Cheers
ChenYu

Chen-Yu Tsai (7):
  ARM: sunxi: Introduce Allwinner A80 support
  ARM: sunxi: Add debug uart used by sun9i (Allwinner A80)
  ARM: dts: sunxi: Add Allwinner A80 dtsi
  ARM: dts: sun9i: Add A80 Optimus Board support
  devicetree: bindings: Add vendor prefix for Merrii Technology Co.,
    Ltd.
  devicetree: bindings: Document supported Allwinner sunxi SoCs
  Documentation: sunxi: Add A80 datasheet link

 Documentation/arm/sunxi/README                     |   3 +-
 Documentation/devicetree/bindings/arm/sunxi.txt    |  12 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/Kconfig.debug                             |  10 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/sun9i-a80-optimus.dts            |  66 +++++
 arch/arm/boot/dts/sun9i-a80.dtsi                   | 287 +++++++++++++++++++++
 arch/arm/mach-sunxi/Kconfig                        |   5 +
 arch/arm/mach-sunxi/sunxi.c                        |   9 +
 9 files changed, 394 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi.txt
 create mode 100644 arch/arm/boot/dts/sun9i-a80-optimus.dts
 create mode 100644 arch/arm/boot/dts/sun9i-a80.dtsi

-- 
2.1.0
