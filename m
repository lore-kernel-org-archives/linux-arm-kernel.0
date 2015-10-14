From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Oct 2015 13:03:36 -0700
Subject: [GIT PULL] omap fixes against v4.3-rc5
Message-ID: <20151014200336.GJ10113@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.3/fixes-rc5

for you to fetch changes up to d8e1f5ed11a39a68da00f05000466c4f6db4456e:

  Documentation: ARM: List new omap MMC requirements (2015-10-12 16:23:34 -0700)

----------------------------------------------------------------
Fixes for omap against v4.3-rc5:

- Regulator fix for beagle-x15 to fix HDMI without a SD card being
  inserted

- GPMC fix for showing proper timings and to allow enabling debug
  options that somehow was unselectable earlier

- Add minimal documentation for new MMC1 dependency on
  REGULATOR_PBIAS as it may not be obvious for people with
  targeted .config files

----------------------------------------------------------------
Tomi Valkeinen (1):
      ARM: dts: am57xx-beagle-x15: set VDD_SD to always-on

Tony Lindgren (2):
      memory: omap-gpmc: Fix unselectable debug option for GPMC
      Documentation: ARM: List new omap MMC requirements

Uwe Kleine-K?nig (1):
      memory: omap-gpmc: dump "before" state before first modification

 Documentation/arm/OMAP/README           |  7 +++++++
 arch/arm/boot/dts/am57xx-beagle-x15.dts |  3 ++-
 drivers/memory/Kconfig                  | 12 +++++++++---
 drivers/memory/omap-gpmc.c              |  2 +-
 4 files changed, 19 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/arm/OMAP/README
