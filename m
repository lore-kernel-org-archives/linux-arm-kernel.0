From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 23 Jul 2013 12:06:43 +0300
Subject: [PATCH 0/2] OMAP: Panda DVI fix and a cleanup
Message-ID: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here's a fix for 3.11 that makes EDID read for DVI work again.

I also included a cleanup patch that removes the non-DT support functions that
are no longer called from anywhere. It's not a fix, but as we're in quite early
rcs, I thought it would be nice to remove the dead code.

Up to you if you want to include that one for 3.11 or not. If not, I'll include
it in a board file series for 3.12 that I'll send soon.

 Tomi

Tomi Valkeinen (2):
  ARM: OMAP: dss-common: fix Panda's DVI DDC channel
  ARM: OMAP2+: Remove legacy DSS initialization for omap4

 arch/arm/mach-omap2/dss-common.c | 49 +---------------------------------------
 arch/arm/mach-omap2/dss-common.h |  2 --
 2 files changed, 1 insertion(+), 50 deletions(-)

-- 
1.8.1.2
