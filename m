From: s.peter@mpl.ch (Stefan Peter)
Date: Sun, 18 Nov 2012 16:46:15 +0100
Subject: [PATCH 0/1 V2] ARM: kirkwood: Add support for the MPL CEC4
Message-ID: <cover.1353238973.git.s.peter@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MPL CEC4 is a compact industrial computer for harsh environments. You
can find out more about it at http://www.mpl.ch/t2640.html

This patch adds basic board support using the device tree where possible.

Changes since V1
* Replaced the 'compatible' entry "mpl,mplcec4", with "mpl,cec4-10", 
  "mpl,cec4" in kirkwood-mplcec4.dts
* Removed unneeded clk headers in board-mplcec4.c
* Fixed sorting order of the kirkwood-mplcec4.dts entry in
  arm/boot/dts/Makefile

Stefan Peter (1):
  Add support for the MPL CEC4

 arch/arm/boot/dts/Makefile             |    1 +
 arch/arm/boot/dts/kirkwood-mplcec4.dts |  119 ++++++++++++++++++++++++++++++++
 arch/arm/configs/kirkwood_defconfig    |    1 +
 arch/arm/mach-kirkwood/Kconfig         |    7 ++
 arch/arm/mach-kirkwood/Makefile        |    1 +
 arch/arm/mach-kirkwood/board-dt.c      |    4 ++
 arch/arm/mach-kirkwood/board-mplcec4.c |   80 +++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h        |    6 ++
 8 files changed, 219 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-mplcec4.dts
 create mode 100644 arch/arm/mach-kirkwood/board-mplcec4.c

-- 
1.7.9.5
