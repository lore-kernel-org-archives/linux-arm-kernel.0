From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Mar 2012 10:27:43 +0100
Subject: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Message-ID: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is a proposition to improve a bit the code.
The changes are code cleanup and does not change the behavior of the
driver itself.

A couple a things call my intention. Why the cpuidle device is set for cpu0 only
and why the WFI is not used ?

Daniel Lezcano (7):
  ARM: OMAP4: cpuidle - Remove unused valid field
  ARM: OMAP4: cpuidle - Declare the states with the driver declaration
  ARM: OMAP4: cpuidle - Remove the cpuidle_params_table table
  ARM: OMAP4: cpuidle - fix static omap4_idle_data declaration
  ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compile time
  ARM: OMAP4: cpuidle - use the omap4_idle_data variable directly
  ARM: OMAP4: cpuidle - remove omap4_idle_data initialization at boot
    time

 arch/arm/mach-omap2/cpuidle44xx.c |  126 ++++++++++++++++---------------------
 1 files changed, 54 insertions(+), 72 deletions(-)

-- 
1.7.5.4
