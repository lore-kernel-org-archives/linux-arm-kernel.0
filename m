From: nm@ti.com (Nishanth Menon)
Date: Thu, 31 May 2012 20:41:35 -0500
Subject: [PATCH V4 0/4] ARM: OMAP3+: VP: collate fixes
Message-ID: <1338514899-3560-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reviewing the android code base brought out a few fixes that upstream
does not have, so collating them and posting them out in this chain.

Nishanth Menon (3):
  ARM: OMAP3+: PM: VP: check only the VPINIDLE status bit
  ARM: OMAP3+: PM: VP: move check of idle to separate function
  ARM: OMAP3+: PM: VP: check to ensure VP is idle before forceupdate

Wenbiao Wang (1):
  ARM: OMAP3+: PM: VP: ensure VP is idle before disable

 arch/arm/mach-omap2/vp.c          |   65 +++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/vp.h          |   10 ++++--
 arch/arm/mach-omap2/vp3xxx_data.c |    1 +
 arch/arm/mach-omap2/vp44xx_data.c |    1 +
 4 files changed, 65 insertions(+), 12 deletions(-)

Changes in v4:
	vp idle moved off to a seperate function
	reordered patches to reduce loc changes
	rate controlled warnings

Previous revs:
	V1: http://marc.info/?l=linux-omap&m=133736976423629&w=2

Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
--
Regards,
Nishanth Menon
-- 
1.7.9.5
