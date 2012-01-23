From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Mon, 23 Jan 2012 16:43:06 +0530
Subject: [PATCH RFC 0/2] watchdog  boot status
Message-ID: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does the following
Patch 1:
Fixes the omap_prcm_get_reset_sources() for omap3/4

Patch 2:
Extends the WDIOC_GETBOOTSTATUS to support omap3/4.

Tested on omap3sdp and omap4sdp.

Rajendra Nayak (1):
  ARM: omap: Fix omap_prcm_get_reset_sources() for omap3/4

Shubhrajyoti D (1):
  watchdog : omap_wdt : Implement WDIOC_GETBOOTSTATUS for omap3+

 arch/arm/mach-omap2/prcm.c    |   13 ++++++++-----
 arch/arm/mach-omap2/prm44xx.h |    3 ---
 drivers/watchdog/omap_wdt.c   |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)
