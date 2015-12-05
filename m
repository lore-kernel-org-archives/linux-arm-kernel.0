From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  5 Dec 2015 21:16:41 +0800
Subject: [PATCH resend 0/6] ARM: sunxi: Add support for A10/A20 Video Engine
 clocks
Message-ID: <1449321407-4531-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

(Series resent with linux-arm-kernel list added.)

This series adds support for the clocks used by the Video Engine (VPU /
video codec hardware) on the Allwinner A10/A20. The series purposely
excludes sun5i (A10s/A13/R8) to avoid any conflicts with Maxime's KMS
driver series, but adding it should be easy. VE clocks for the newer
generation of SoCs are the same, except the reset control is moved to
the common bus reset controls. These can be supported later on.

The series is meant to get platform stuff out of the way so people who
want to work on a proper driver for the VPU can do so.

The patches are pretty self-explanatory.

Regards
ChenYu

Chen-Yu Tsai (6):
  clk: sunxi: Add DRAM gates support for sun4i-a10
  clk: sunxi: Add VE (Video Engine) module clock driver for sun[457]i
  ARM: dts: sun4i: Add DRAM gates
  ARM: dts: sun4i: Add VE (Video Engine) module clock node
  ARM: dts: sun7i: Add DRAM gates
  ARM: dts: sun7i: Add VE (Video Engine) module clock node

 Documentation/devicetree/bindings/clock/sunxi.txt |   5 +
 arch/arm/boot/dts/sun4i-a10.dtsi                  |  45 +++++-
 arch/arm/boot/dts/sun7i-a20.dtsi                  |  41 +++++-
 drivers/clk/sunxi/Makefile                        |   1 +
 drivers/clk/sunxi/clk-a10-ve.c                    | 171 ++++++++++++++++++++++
 drivers/clk/sunxi/clk-simple-gates.c              |  12 ++
 6 files changed, 268 insertions(+), 7 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-a10-ve.c

-- 
2.6.2
