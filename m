From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 10 Feb 2015 15:58:36 +0200
Subject: [PATCH 0/7] ARM: davinci: McASP related cleanups and fixes
Message-ID: <1423576723-24375-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Clean up series of McASP device creation for da8xx and dm646x DMSoCs.

Patch5 (dm646x: Clean up the McASP DMA resources) depends on a patch queed for
3.20 via ASoC:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/087321.html

There is another daVinci related fix going via ASoC for da830, which have shared
irq line for all it's McASP ip:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/087322.html

Regards,
Peter
---
Peter Ujfalusi (7):
  ARM: davinci: devices-da8xx: Add resource name for the McASP DMA
    request
  ARM: davinci: devices-da8xx: Add interrupt resource to McASP structs
  ARM: davinci: devices-da8xx: Clean up and correct the McASP device
    creation
  ARM: davinci: devices-da8xx: Add support for McASP2 on da830
  ARM: davinci: dm646x: Clean up the McASP DMA resources
  ARM: davinci: irqs: Correct McASP1 TX interrupt definition for DM646x
  ARM: davinci: dm646x: Add interrupt resource for McASPs

 arch/arm/mach-davinci/asp.h               |  7 +++
 arch/arm/mach-davinci/devices-da8xx.c     | 80 ++++++++++++++++++++++++++++---
 arch/arm/mach-davinci/dm646x.c            | 23 ++++++---
 arch/arm/mach-davinci/include/mach/irqs.h |  2 +-
 4 files changed, 98 insertions(+), 14 deletions(-)

-- 
2.3.0
