From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Thu, 23 Feb 2012 17:40:25 +0530
Subject: [PATCH 0/6] gpio/omap: Some more driver cleanup and fixes
Message-ID: <1329999031-6914-1-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cleanup is mostly getting rid of redundant fields in struct gpio_bank{}
as we already have them as part of bank->context now. Also, remove un-used
variable from gpio_irq_handler.

The fix include correction of _set_gpio_irqenable() implementation and fix
type mismatch of gpio trigger parameter.

It is baselined on top of Kevin's following series:
gpio/omap: cleanup and runtime PM conversion for v3.4
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/gpio/runtime-pm-cleanup

I have applied Benoit's GPIO patches in following series on top of Kevin's
before applying my changes.
gpio/omap: Cleanup and adaptation to Device Tree
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_gpio

Series is available here for reference:
git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_further_cleanup_fixes

Power Test: Off-mode and Retention on OMAP3430 (Suspend and Idle paths).
Functional Test: OMAP2430, OMAP3430SDP, ZOOM3, OMAP4430, OMAP4-BLAZE

Tarun Kanti DebBarma (6):
  gpio/omap: remove saved_fallingdetect, saved_risingdetect fields
  gpio/omap: remove saved_wakeup field from struct gpio_bank
  gpio/omap: remove suspend_wakeup field from struct gpio_bank
  gpio/omap: get rid of retrigger variable in gpio_irq_handler
  gpio/omap: fix trigger type to unsigned
  gpio/omap: fix _set_gpio_irqenable implementation

 drivers/gpio/gpio-omap.c |   56 +++++++++++++++++++--------------------------
 1 files changed, 24 insertions(+), 32 deletions(-)
