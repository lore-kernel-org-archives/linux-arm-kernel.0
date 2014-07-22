From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 22 Jul 2014 16:57:06 -0400
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 3)
Message-ID: <20140722205706.GA23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Here's the cpufreq changes I mentioned over the weekend.  It's been in
-next for a while.  Once I get the new version of cpuidle from ThomasP,
I'll push that as quickly as possible.

As usual (do I need to type this each time any more? :) ), this is an
incremental pull request from tags/mvebu-soc-3.17-2 up to
tags/mvebu-soc-3.17-3 on the mvebu/soc branch.

Please pull.

thx,

Jason.


The following changes since commit ba364fc752daeded072a5ef31e43b84cb1f9e5fd:

  ARM: Kirkwood: Remove mach-kirkwood (2014-07-13 22:13:39 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.17-3

for you to fetch changes up to ba3ec5780bba27819bbc4f669e6c77418a00f14b:

  Merge branch 'mvebu/soc-cpufreq' into mvebu/soc (2014-07-22 20:46:48 +0000)

----------------------------------------------------------------

mvebu SoC changes for v3.17 (round 3)

 - mvebu:
    - Add cpufreq support for Armada XP

----------------------------------------------------------------
Jason Cooper (1):
      Merge branch 'mvebu/soc-cpufreq' into mvebu/soc

Thomas Petazzoni (3):
      ARM: mvebu: ensure CPU clocks are enabled
      ARM: mvebu: extend PMSU code to support dynamic frequency scaling
      clk: mvebu: extend clk-cpu for dynamic frequency scaling

 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   5 +-
 arch/arm/mach-mvebu/platsmp.c                      |   1 +
 arch/arm/mach-mvebu/pmsu.c                         | 162 +++++++++++++++++++++
 drivers/clk/mvebu/clk-cpu.c                        |  80 +++++++++-
 include/linux/mvebu-pmsu.h                         |  20 +++
 5 files changed, 261 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/mvebu-pmsu.h
