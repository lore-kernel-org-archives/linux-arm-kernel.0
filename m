From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Aug 2015 03:40:31 -0700
Subject: [GIT PULL] omap pbias regulator regression fixes against v4.2-rc5
Message-ID: <20150806104031.GE4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9908ac3daa3da2d236b5406b95d0865ddb8b29c4:

  ARM: dts: Correct audio input route & set mic bias for am335x-pepper (2015-07-15 03:03:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc5

for you to fetch changes up to cd4556733b30cc363adc7b1cea3bffa7e2dd0c7c:

  ARM: dts: dra7: Fix broken pbias device creation (2015-08-05 03:04:07 -0700)

----------------------------------------------------------------
Few trivial omap MMC regression fixes for card voltages where
the syscon areas for PBIAS regulator were missing "simple-bus"
that prevents probing of the children in the mapped region.

This probably was not noticed earlier as the bootloader has
already configured the regulator for the card in the slot.

----------------------------------------------------------------
Kishon Vijay Abraham I (4):
      ARM: dts: omap243x: Fix broken pbias device creation
      ARM: dts: OMAP4: Fix broken pbias device creation
      ARM: dts: OMAP5: Fix broken pbias device creation
      ARM: dts: dra7: Fix broken pbias device creation

 arch/arm/boot/dts/dra7.dtsi     | 2 +-
 arch/arm/boot/dts/omap2430.dtsi | 3 ++-
 arch/arm/boot/dts/omap4.dtsi    | 3 ++-
 arch/arm/boot/dts/omap5.dtsi    | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)
