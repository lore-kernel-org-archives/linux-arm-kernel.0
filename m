From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 22 Nov 2011 23:54:22 +0800
Subject: [PATCH v7 0/3] ARM: mxs: add recording support for saif
In-Reply-To: <a>
References: <a>
Message-ID: <1321977265-14959-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v6:
 * fix a typo suggested by Shawn
 * add tag from Marek Vasut

Changes since v5:
 Only one change is that:
 * remove the unneccesary parenthesis for [PATCH 1/3] suggested
   by Marek Vasut.

Changes since v4:
 * use new added master_id and master_mode in platform_data.
 The new changes depend on another patch:
 0001-ASoC-mxs-saif-remove-function-in-platform_data.patch

Changes since v3:
 * remove unneeded locking according to Sascha.
The patches are based on imx-features branch since commit:
ca4e419c2.

Changes since v2:
 * separate clkmux code into another patch according to Uwe
 * add lock according to Wolfram
 * Other minus fixes suggested by Uwe and Wolfram.
 * remove Wolfram's fix saif clock setting patch which is in v2 series
   since Wolfram will reform the clock code and send it out himself.
   For test purpose, user still needs that patch. People can get it
   from v2 series.
   The patch is:
   [PATCH v2 3/3] arm: mxs: disable clock-gates when setting saif-clocks

The patches are based on imx-features branch since commit:
f4f01e31835f.

Changes since v1:
The main changes are move mach-specific code(clkmux in DIGCTL) from
saif driver to mach-specific layer based on Wolfram's suggestion.

Note that the last patch is a RFC patch and sent out for testing
since without that patch the saif may not work.

Dong Aisheng (3):
  ARM: mxs: add saif clkmux functions
  ARM: mx28evk: add platform data for saif
  ARM: mx28evk: set a initial clock rate for saif

 arch/arm/mach-mxs/clock-mx28.c                  |   38 +++++++++++++++++++++++
 arch/arm/mach-mxs/devices-mx28.h                |    3 +-
 arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 ++-
 arch/arm/mach-mxs/include/mach/common.h         |    1 +
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 ++-
 arch/arm/mach-mxs/include/mach/digctl.h         |   21 ++++++++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   18 +++++++++-
 7 files changed, 84 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
