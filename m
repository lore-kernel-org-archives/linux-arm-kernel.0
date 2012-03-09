From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 9 Mar 2012 14:41:45 +0530
Subject: [PATCH 0/4] hsmmc cleanups in platform callback routines
Message-ID: <1331284309-22101-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series mainly splits the platform callbacks implemented in
hsmmc.c (for clk source selection and pbiascell programming)
rather than doing everything in a single callback which
is what is done today. This cleanup is ground work before all these
callbacks are moved into hsmmc/system-control module driver
out of machine folder.

Patches tested on omap3 beagle-Xm and omap4 panda boards.

regards,
Rajendra

Rajendra Nayak (4):
  ARM: OMAP2+: hsmmc: Add a flag to identify modules supporting clock
    src selection
  ARM: OMAP2+: hsmmc: Split the clock src selection and pbias
    programming
  ARM: OMAP2+: hsmmc: Let board files specify if an external
    transceiver exists
  ARM: OMAP2430SDP: No support to switch to external clock on omap2430

 arch/arm/mach-omap2/board-2430sdp.c        |    1 -
 arch/arm/mach-omap2/hsmmc.c                |  101 ++++++++++++----------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   14 +++-
 arch/arm/plat-omap/include/plat/mmc.h      |    2 +
 drivers/mmc/host/omap_hsmmc.c              |    3 +
 5 files changed, 58 insertions(+), 63 deletions(-)
