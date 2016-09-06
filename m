From: manabian@gmail.com (Joachim Eastwood)
Date: Tue,  6 Sep 2016 22:16:00 +0200
Subject: [GIT PULL] LPC18xx DTS changes for v4.9 part2
Message-ID: <20160906201600.31373-1-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc team,

Please consider pulling these DTS changes for the NXP LPC18xx
platform into arm-soc/dt for Linux 4.9. Note that this should
go ontop of the previous pull request. 
See: http://www.spinics.net/lists/arm-kernel/msg526910.html

This clean up removes the skeleton.dtsi from the common arm7-m
dtsi and from both the lpc18xx and efm32 platform. All these
changes has been acked by the other platform maintainers.

In addition there are some fixes for the unit address warnings
from dtc. With these fixes both lpc18xx and efm32 are now
warning free. The efm32 only patch included here has been acked
by Uwe Kleine-K?nig.


  ARM: dts: lpc18xx: configure dwmac properly (2016-08-27 16:13:19 +0200)

are available in the git repository at:

  https://github.com/manabian/linux-lpc tags/lpc18xx_dts_for_4.9_part2

for you to fetch changes up to 836407462244cc4d8b1172f1f835035801692a77:

  ARM: dts: efm32: remove skeleton.dtsi include and fix unit address warnings (2016-09-06 21:53:16 +0200)

----------------------------------------------------------------
Device Tree clean up for LPC18xx platform

* Removal of skeleton.dtsi from the common armv7-m dtsi together
  with lpc18xx and efm32 platforms.

* Fix for unit address warnings from the dtc on lpc18xx/efm32.
  That is made possible with skeleton.dtsi gone.

----------------------------------------------------------------
Joachim Eastwood (3):
      ARM: dts: armv7-m: remove skeleton.dtsi include
      ARM: dts: lpc18xx: remove skeleton.dtsi include and fix unit address warnings
      ARM: dts: efm32: remove skeleton.dtsi include and fix unit address warnings

 arch/arm/boot/dts/armv7-m.dtsi              | 2 --
 arch/arm/boot/dts/efm32gg-dk3750.dts        | 5 +++--
 arch/arm/boot/dts/efm32gg.dtsi              | 4 ++++
 arch/arm/boot/dts/lpc18xx.dtsi              | 3 +++
 arch/arm/boot/dts/lpc4337-ciaa.dts          | 2 +-
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    | 2 +-
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 2 +-
 arch/arm/boot/dts/mps2.dtsi                 | 1 +
 arch/arm/boot/dts/stm32f429.dtsi            | 1 +
 arch/arm/boot/dts/vf610m4.dtsi              | 1 +
 10 files changed, 16 insertions(+), 7 deletions(-)
