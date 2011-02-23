From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Feb 2011 11:58:47 -0700
Subject: [PATCH 0/5] ARM: Tegra: Harmony: Enable audio driver
Message-ID: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables the audio driver for Tegra Harmony.

Important notes:
* This series is based on Olof's recently posted boards-for-next branch.
  Some patches won't apply without that being in first.
* The final patch in the series depends on header adds/edits that are not
  in Tegra's for-next branch

See notes in the individual patches for further details.

Stephen Warren (5):
  ARM: Tegra: Add devices.c entries for audio
  ARM: Tegra: Rename I2S clocks to match driver name
  ARM: Tegra: Rename clk_dev1/2 to cdev1/2
  ARM: Tegra: Create defines for GPIO names
  ARM: Tegra: Enable Harmony audio support

 arch/arm/mach-tegra/board-harmony-pinmux.c  |   28 ++++++-----
 arch/arm/mach-tegra/board-harmony.c         |   70 ++++++++++++++++++++++++--
 arch/arm/mach-tegra/board-harmony.h         |   14 +++++
 arch/arm/mach-tegra/board-seaboard-pinmux.c |   10 ++--
 arch/arm/mach-tegra/board-seaboard.c        |    6 +-
 arch/arm/mach-tegra/board-seaboard.h        |    3 +
 arch/arm/mach-tegra/devices.c               |   70 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/devices.h               |    4 ++
 arch/arm/mach-tegra/include/mach/iomap.h    |    3 +
 arch/arm/mach-tegra/tegra2_clocks.c         |   16 +++---
 10 files changed, 190 insertions(+), 34 deletions(-)
