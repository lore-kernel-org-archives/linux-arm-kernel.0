From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 11 Jun 2016 19:39:48 +0200
Subject: [PATCH v2 0/3] clk: sunxi-ng: Add the A83T clocks
Message-ID: <cover.1465666788.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds the clocks of the sunxi A83T in the "modern"
clock framework proposed by Maxime Ripard.
It applies on the V2 of his patch series.

It is currently being tested on a Banana Pi M3 with the legacy u-boot.
- working:
	mmc0
	mmc2 (eMMC) but slow clock
	ths
	uart0
	usb0
- not working:
	mmc1 (wifi/bt)
	video (machine freeze on reading/writing the DE I/O memory)
- not yet tested
	audio
	prcm

Jean-Francois Moine (3):
  clk: sunxi-ng: Add N-D-M-P-factor clock support
  clk: sunxi-ng: Add the A83T clocks and resets
  dt: sun8i: Define the clocks of the A83T

 arch/arm/boot/dts/sun8i-a83t.dtsi      |  18 +-
 drivers/clk/sunxi-ng/Makefile          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c  | 675 +++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_common.h      |   1 +
 drivers/clk/sunxi-ng/ccu_ndmp.c        | 239 ++++++++++++
 drivers/clk/sunxi-ng/ccu_ndmp.h        |  96 +++++
 include/dt-bindings/clock/sun8i-a83t.h | 150 ++++++++
 include/dt-bindings/reset/sun8i-a83t.h |  94 +++++
 8 files changed, 1270 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.h
 create mode 100644 include/dt-bindings/clock/sun8i-a83t.h
 create mode 100644 include/dt-bindings/reset/sun8i-a83t.h

-- 
2.8.4
