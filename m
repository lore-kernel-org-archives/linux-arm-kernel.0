From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 11:24:33 -0700
Subject: [GIT PULL 1/6] non-critical omap fixes for v3.11 merge window
Message-ID: <pull-1371061475-206272>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/fixes-non-critical-signed

for you to fetch changes up to e41a5f88b374f7b1d87a72740d186be20cae4aa8:

  ARM: OMAP2+: omap-usb-host: Fix memory leaks (2013-06-12 10:04:10 -0700)

----------------------------------------------------------------
Non-critical fixes for omaps for v3.11 merge window.

----------------------------------------------------------------
Peter Ujfalusi (3):
      ARM: OMAP2+: devices: Do not print error when McPDM hwmod lookup fails
      ARM: OMAP2+: devices: Do not print error when DMIC hwmod lookup fails
      ARM: OMAP2+: devices: Do not print error when dss_hdmi hwmod lookup fails

Roger Quadros (1):
      ARM: OMAP2+: omap-usb-host: Fix memory leaks

Sebastian Andrzej Siewior (1):
      arm/omap: use const char properly

Suman Anna (1):
      ARM: OMAP2+: control: add OMAP5 support for dsp boot programming

Tomi Valkeinen (3):
      ARM: OMAP: fix dsi regulator names
      ARM: OMAP: add vdds_dsi supply for omapdss_dpi.0
      ARM: OMAP: add vdds_sdi supply for omapdss_sdi.0

Tony Lindgren (2):
      Merge branch 'dss-regulator' into omap-for-v3.11/fixes-non-critical
      ARM: OMAP2+: Fix serial init for device tree based booting

 arch/arm/mach-omap2/board-cm-t35.c           |   3 +-
 arch/arm/mach-omap2/board-devkit8000.c       |   1 +
 arch/arm/mach-omap2/board-ldp.c              |   3 +-
 arch/arm/mach-omap2/board-omap3pandora.c     |   1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |   1 +
 arch/arm/mach-omap2/control.c                |   1 +
 arch/arm/mach-omap2/devices.c                |  12 +--
 arch/arm/mach-omap2/id.c                     |   2 +-
 arch/arm/mach-omap2/serial.c                 |   3 +
 arch/arm/mach-omap2/twl-common.c             |   1 +
 arch/arm/mach-omap2/usb-host.c               | 106 ++++++++++++++-------------
 11 files changed, 72 insertions(+), 62 deletions(-)
