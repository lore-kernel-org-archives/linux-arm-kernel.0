From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 14 Jun 2012 15:27:23 +0300
Subject: [PATCH 0/3] ARM: OMAP2/3: Move McBSP fck alias to hwmod data
Message-ID: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

To keep the McBSP fck alias handling in sync among OMAP versions.
Change the legacy implementation for OMAP2/3 regarding to McBSP fck alias.
OMAP4 (and OMAP5) uses the hwmod data to specify the aliases for the fcks and
it is also needed for the coming McBSP DT support.

Tested on OMAP3 BeagleBoard, compile tested it for OMAP2.

Regards,
Peter

---
Peter Ujfalusi (3):
  ARM: OMAP2: Move McBSP fck clock alias to hwmod data for OMAP2420
  ARM: OMAP2: Move McBSP fck clock alias to hwmod data for OMAP2430
  ARM: OMAP3: Move McBSP fck clock alias to hwmod data

 arch/arm/mach-omap2/clock2420_data.c       |    4 ----
 arch/arm/mach-omap2/clock2430_data.c       |   10 ----------
 arch/arm/mach-omap2/clock3xxx_data.c       |   10 ----------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   15 +++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   21 +++++++++++++++++++++
 6 files changed, 45 insertions(+), 24 deletions(-)

-- 
1.7.8.6
