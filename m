From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 13 Dec 2010 22:49:24 +0100
Subject: [PATCH 0/5] OMAP3&4: Fixes in setup/suspend/powerdomain
Message-ID: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

This is a series of fixes on OMAP3/4 in setup apis,
in the suspend framework and in powerdomain modelling
for OMAP4.

The series is based on your power domain series and is available here:
git://gitorious.org/omap-pm/linux.git for_2.6.38/power

Tested on 4430sdp + ES2.0 with omap2plus_defconfig.
Tested on 3430sdp - validate OFF in suspend, with omap3_pm_defconfig
from Kevin's tree.
Tested on 2430sdp after fixing the break on linux-omap master.
See http://www.spinics.net/lists/linux-omap/msg42050.html

Regards,
Rajendra, Santosh & Benoit


Rajendra Nayak (3):
  OMAP4: PM: Use the lowpwrstatechange feature on OMAP4
  OMAP4: PM: Do not assume clkdm supports hw transitions
  OMAP4: powerdomain: l4per pwrdm does not support OFF

Santosh Shilimkar (2):
  OMAP4: powerdomain: Remove L3INIT_PD OFF state
  OMAP4: clock data: Keep L3INSTR clock domain modulemode under HW control

 arch/arm/mach-omap2/clock44xx_data.c        |    3 +++
 arch/arm/mach-omap2/pm.c                    |   16 +++++++++++++---
 arch/arm/mach-omap2/powerdomains44xx_data.c |    4 ++--
 3 files changed, 18 insertions(+), 5 deletions(-)
