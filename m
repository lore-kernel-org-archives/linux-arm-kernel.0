From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 23 Sep 2017 08:15:28 +0800
Subject: [PATCH 0/3] Simple DVFS support for Allwinner A64 SoC
Message-ID: <20170923001531.14285-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset imports simple DVFS support for Allwinner A64 SoC.

As the thermal sensor driver is not yet implemented and some boards
have still no AXP PMIC support, now only two OPPs are present --
648MHz at 1.04V and 816MHz at 1.1V to prevent overheat or undervoltage.

PATCH 1 is a fix to the CCU driver of A64, and the remaining patches
set up the device tree bits of the DVFS on Pine64.

Icenowy Zheng (3):
  clk: sunxi-ng: add mux and pll notifiers for A64 CPU clock
  arm64: allwinner: a64: add CPU opp table
  arm64: allwinner: a64: set CPU regulator for Pine64

 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 24 +++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              | 28 +++++++++++++++++++++-
 3 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.13.5
