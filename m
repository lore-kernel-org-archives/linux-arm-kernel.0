From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 4 Oct 2011 23:20:39 +0200
Subject: [PATCH 0/2] ARM: OMAP2+: timer fixes / cleanup
Message-ID: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Here is the series to fix the warning and remove the redundant
latency structure that be removed since the timer runtime PM
adaptation was just pulled.

I was just able to test that on OMAP4.

Patches are based on Kevin's for_3.2/omap_device-2 branch
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/timer_fixes

Regards,
Benoit


Benoit Cousson (2):
  ARM: OMAP2+: clock data: Remove redundant timer clkdev
  ARM: OMAP2+: timer: Remove omap_device_pm_latency

 arch/arm/mach-omap2/clock2420_data.c |   12 ------------
 arch/arm/mach-omap2/clock2430_data.c |   12 ------------
 arch/arm/mach-omap2/clock3xxx_data.c |   12 ------------
 arch/arm/mach-omap2/clock44xx_data.c |   11 -----------
 arch/arm/mach-omap2/timer.c          |   12 +-----------
 5 files changed, 1 insertions(+), 58 deletions(-)
