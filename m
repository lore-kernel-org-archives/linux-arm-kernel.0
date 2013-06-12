From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 12 Jun 2013 16:52:38 -0400 (EDT)
Subject: [GIT PULL] MCPM backend for VExpress TC2
Message-ID: <alpine.LFD.2.03.1306121612150.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARnd, Olof, please pull the following:

        git://git.linaro.org/people/nico/linux TC2

This is the MCPM backend submission for VExpress with a TC2 core tile.
This enables SMP secondary boot, CPU hotplug, and paves the way for 
cpuidle and cpufreq on this platform.

A big prerequisite for this support is the serial power controller 
driver posted by Lorenzo and extensively reviewed on the list.  Because 
of the strict dependency, we asked Samuel Ortiz twice for his ACK to 
merge it via ARM-SOC:

	http://article.gmane.org/gmane.linux.kernel/1506121

But no reply came back so far.  If Samuel had any issues with this 
driver I'm trusting he would have had ample time to express them at this 
point.  I'm therefore including it by default.

This is based on ARM-SOC's vexpress/dual-cluster branch as this also 
needs the CCI driver and commit 033a899c9b already in that branch to 
work properly, as well as the existing prerequisite from RMK's tree for 
that branch.

Diffstat for 033a899c9b..dbe5a98089

 .../devicetree/bindings/mfd/vexpress-spc.txt    |  35 +
 arch/arm/mach-vexpress/Kconfig                  |   9 +
 arch/arm/mach-vexpress/Makefile                 |   1 +
 arch/arm/mach-vexpress/tc2_pm.c                 | 295 ++++++++
 drivers/mfd/Kconfig                             |   7 +
 drivers/mfd/Makefile                            |   1 +
 drivers/mfd/vexpress-config.c                   |  61 +-
 drivers/mfd/vexpress-spc.c                      | 633 ++++++++++++++++++
 drivers/mfd/vexpress-sysreg.c                   |   2 +-
 include/linux/vexpress.h                        |  59 +-
 10 files changed, 1075 insertions(+), 28 deletions(-)

Thanks


Nicolas
