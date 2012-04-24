From: govindraj.raja@ti.com (Govindraj.R)
Date: Tue, 24 Apr 2012 19:39:10 +0530
Subject: [PATCH v3 0/2] ARM: omap_hwmod: add api to enable/disable module
 level wakeup
Message-ID: <1335276552-24340-1-git-send-email-govindraj.raja@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Govindraj.R" <govindraj.raja@ti.com>

On omap2/3 module level wakeup is handled using PM_WKEN registers.
Expand the hwmod framework to handle the module level wakeup enable 
registers.

Tested on Beagle-xm by enabling and disabling uart wakeups from sysfs
Series depends on following patches for testing.
http://marc.info/?l=linux-omap&m=133527588923598&w=2
http://marc.info/?l=linux-omap&m=133518614022144&w=2

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Govindraj.R (2):
  ARM: OMAP2+: omap_hwmod: Add api to enable/disable module level
    wakeup events
  ARM: omap3: pm: Remove uart module level wakeup configurations

 arch/arm/mach-omap2/omap_hwmod.c   |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c       |   14 +++++---------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   16 ++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    9 +++++++++
 4 files changed, 52 insertions(+), 9 deletions(-)

-- 
1.7.9
