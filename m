From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Jun 2016 03:48:07 -0700
Subject: [PATCH 0/2] Drop last two remaining omap3 legacy board files
Message-ID: <1465987689-14812-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are two patches to drop the last remaining omap3 legacy boot
files. We have device tree based booting working for these boards,
and the legacy booting has been mostly kept around to validate
against regressions.

Let's not touch the rest of the platform init code until around
v4.9 so we can revert these two patches if needed.

Cheers,

Tony

Tony Lindgren (2):
  ARM: OMAP2+: Drop legacy board file for n900
  ARM: OMAP2+: Drop legacy board file for LDP

 arch/arm/mach-omap2/Kconfig                  |   12 -
 arch/arm/mach-omap2/Makefile                 |    4 -
 arch/arm/mach-omap2/board-ldp.c              |  429 ---------
 arch/arm/mach-omap2/board-rx51-peripherals.c | 1317 --------------------------
 arch/arm/mach-omap2/board-rx51-video.c       |   67 --
 arch/arm/mach-omap2/board-rx51.c             |  141 ---
 arch/arm/mach-omap2/board-rx51.h             |   11 -
 7 files changed, 1981 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-ldp.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51-video.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51.c
 delete mode 100644 arch/arm/mach-omap2/board-rx51.h

-- 
2.8.1
