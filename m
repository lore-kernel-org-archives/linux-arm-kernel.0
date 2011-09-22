From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Sep 2011 14:07:18 -0700
Subject: [PATCH 00/10] cpufreq: OMAP: move into drivers,
	cleanups/fixes for v3.2
Message-ID: <1316725648-26710-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series moves the OMAP CPUfreq driver into drivers/cpufreq, add
support for SMP devices (OMAP4+) and includes several cleanups and
fixes from Nishanth Menon.

This series applies to v3.1-rc6, and is available here:

   git://github.com/khilman/linux-omap-pm.git for_3.2/omap-cpufreq

Kevin


Colin Cross (1):
  cpufreq: OMAP: notify even with bad boot frequency

Nishanth Menon (6):
  cpufreq: OMAP: move clk name decision to init
  cpufreq: OMAP: deny initialization if no mpudev
  cpufreq: OMAP: dont support !freq_table
  cpufreq: OMAP: only supports OPP library
  cpufreq: OMAP: put clk if cpu_init failed
  cpufreq: OMAP: fix freq_table leak

Russell King (1):
  cpufreq: OMAP: Add SMP support for OMAP4+

Santosh Shilimkar (1):
  cpufreq: OMAP: cleanup for multi-SoC support, move into
    drivers/cpufreq

Todd Poynor (1):
  cpufreq: OMAP: Enable all CPUs in shared policy mask

 arch/arm/plat-omap/Makefile    |    1 -
 arch/arm/plat-omap/cpu-omap.c  |  171 -------------------------
 drivers/cpufreq/Makefile       |    1 +
 drivers/cpufreq/omap-cpufreq.c |  271 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 272 insertions(+), 172 deletions(-)
 delete mode 100644 arch/arm/plat-omap/cpu-omap.c
 create mode 100644 drivers/cpufreq/omap-cpufreq.c

-- 
1.7.6
