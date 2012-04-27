From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 Apr 2012 13:05:34 -0700
Subject: [PATCH 0/6] ARM: OMAP: hwmod: remove runtime cpu_is checking
Message-ID: <1335557140-10854-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series attempts to remove all the runtime cpu_is* checking in
omap_hwmod.c in favor of using function pointers initialized at init
time.

This series was motivated by the addition of support for the AM335x
series which was done by adding several more cpu_is* checks, and
provided the proverbial straw that broke the camel's back.  

In addition to the cleanup, this provides a much cleaner way of adding
additional SoC support since it no longer requires adding additional
runtime cpu_is* checks.

Boot tested on OMAP3530/Overo and OMAP4430/Panda.

Kevin Hilman (6):
  ARM: OMAP4: hwmod: rename _enable_module to _omap4_enable_module()
  ARM: OMAP2+: hwmod: use init-time function ptrs for enable/disable
    module
  ARM: OMAP4: hwmod: drop extra cpu_is check from
    _wait_target_disable()
  ARM: OMAP2+: hwmod: use init-time function pointer for
    wait_target_ready
  ARM: OMAP2+: hwmod: use init-time function pointer for hardreset
  ARM: OMAP2+: hwmod: use init-time function pointer for _init_clkdm

 arch/arm/mach-omap2/omap_hwmod.c             |  192 +++++++++++++++-----------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   11 ++
 2 files changed, 126 insertions(+), 77 deletions(-)

-- 
1.7.9.2
