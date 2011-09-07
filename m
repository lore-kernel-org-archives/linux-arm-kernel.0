From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 7 Sep 2011 21:57:35 +0800
Subject: [PATCH v2 0/3] ARM: mxs: add recording support for saif
Message-ID: <1315403858-9904-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first series does not have a cover letter.
Add it now for v2.

The main changes are move mach-specific code(clkmux in DIGCTL) from
saif driver to mach-specific layer based on Wolfram's suggestion.

Note that the last patch is a RFC patch and sent out for testing
since without that patch the saif may not work.

Dong Aisheng (2):
  ARM: mx28evk: add platform data for saif
  ARM: mx28evk: set a initial clock rate for saif

Wolfram Sang (1):
  arm: mxs: disable clock-gates when setting saif-clocks

 arch/arm/mach-mxs/clock-mx28.c                  |   63 ++++++++++++++++++++++-
 arch/arm/mach-mxs/devices-mx28.h                |    4 +-
 arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 +-
 arch/arm/mach-mxs/include/mach/common.h         |    2 +
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +-
 arch/arm/mach-mxs/include/mach/digctl.h         |   18 +++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   15 +++++-
 arch/arm/mach-mxs/regs-clkctrl-mx28.h           |    2 +
 8 files changed, 105 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
