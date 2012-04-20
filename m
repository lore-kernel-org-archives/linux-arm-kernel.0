From: govindraj.raja@ti.com (Govindraj.R)
Date: Fri, 20 Apr 2012 16:40:04 +0530
Subject: [PATCH v2 0/3] ARM: omap_hwmod: add api to enable/disable module
 level wakeup
Message-ID: <1334920207-19160-1-git-send-email-govindraj.raja@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Govindraj.R" <govindraj.raja@ti.com>

On omap2/3 module level wakeup is handled using PM_WKEN registers.
Expand the hwmod framework to handle the module level wakeup enable 
registers.

Tested on Beagle-xm by enabling and disabling uart wakeups from sysfs
Series depends on following patch for testing.
http://marc.info/?l=linux-omap&m=133457952909998&w=2

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>

Govindraj.R (3):
  ARM: OMAP2+: omap_hwmod: Add interface to incorporate module level
    wakeup
  ARM: OMAP2+: omap_hwmod: Add api to enable/disable module level
    wakeup events
  ARM: omap3: pm: Remove uart module level wakeup configurations

 arch/arm/mach-omap2/omap_hwmod.c             |   24 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    8 ++++++++
 arch/arm/mach-omap2/pm34xx.c                 |   14 +++++---------
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |    8 ++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    9 +++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 ++++
 8 files changed, 70 insertions(+), 9 deletions(-)

-- 
1.7.9
