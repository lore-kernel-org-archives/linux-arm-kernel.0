From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 08:26:27 -0800
Subject: [PATCH 0/2] Initcall changes for omaps
Message-ID: <1448900789-4034-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some initcall changes to initialize things a bit later.
This make it easier to make timers into drivers and allows us
to make most of the clocks into regular device drivers.

Regards,

Tony


Tony Lindgren (2):
  ARM: OMAP2+: Initialize timers later with late_time_init
  ARM: OMAP2+: Change core_initcall levels to postcore_initcall

 arch/arm/mach-omap2/omap2-restart.c |  2 +-
 arch/arm/mach-omap2/omap_device.c   |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c    |  2 +-
 arch/arm/mach-omap2/serial.c        |  2 +-
 arch/arm/mach-omap2/timer.c         | 46 ++++++++++++++++++++++++++++++++-----
 5 files changed, 44 insertions(+), 10 deletions(-)

-- 
2.6.2
