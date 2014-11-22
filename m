From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 22 Nov 2014 17:19:21 +0100
Subject: [PATCHv0 0/2] arm: mvebu: fixes for previous DS213j/DS414 series
Message-ID: <cover.1416670812.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

This series contains two patches. I spent some time reading the patches
of my previous series you had to manually apply. I only noticed the error
Ben reported on v6 (i.e. some pinctrl entries still using pmx_ instead
of _pins) which patch 1 corrects.

Regarding the second patch, having forgotten to enable MACH_ARMADA_XP in
my kernel config, I missed a renaming of ge0/1 pinctrl entries in
armada-xp.dtsi, which resulted in a non-compiling .dts file for DS414.
To fix my mistake, you did a s/ge[01]_rgmii_pins/pmx_ge[01]_rgmii/,
reintroducing some of the pmx_ naming that should have been removed in
the process. So, the second patch in that series finishes the work to
normalize pinctrl entries in Armada SoCs DT files.

The patches do apply on your mvebu/dt branch. They do pass a whole
compilation (including 'make dtbs') and I can boot a resulting kernel on
my DS213j. I do not have a DS414 at hand but will test on this device
early next week.

I hope eveyhting is now back in order w/ those. Feedback appreciated.

Cheers,

a+

Arnaud Ebalard (2):
  arm: mvebu: fix wrongly named DS414 pinctrl entries
  arm: mvebu: normalize pinctrl entries for Armada SoCs

 arch/arm/boot/dts/armada-xp-axpwifiap.dts       | 12 ++++++------
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts |  4 ++--
 arch/arm/boot/dts/armada-xp-synology-ds414.dts  | 10 +++++-----
 arch/arm/boot/dts/armada-xp.dtsi                |  6 +++---
 4 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.1.1
