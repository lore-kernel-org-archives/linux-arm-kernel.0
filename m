From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed,  6 Jul 2016 01:59:19 +0530
Subject: [PATCH v3 0/2] Add CPU clock support for Exynos7
Message-ID: <1467750561-13957-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the atlas clock hierarchy on Exynos7. It also
modifies the existing cpu clock infrastructure to handle exynos7
differences. These patches are a pre-requisite for enabling CPUFreq
on Exynos7. This patchset has been tested on next-20160704. The
opp device tree changes, cpufreq-dt platform addition and defconfig
enablement will be sent separately.

Previous version of this patchset can be found here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/322499.html

Changes since v2:
	- All the dependencies have been merged
	- Code is now based on exynos5433 cpu clock support

Abhilash Kesavan (2):
  clk: samsung: cpu: Prepare for addition for Exynos7 CPU clocks
  clk: samsung: exynos7: Add clocks for atlas block

 .../devicetree/bindings/clock/exynos7-clock.txt    |   6 +
 drivers/clk/samsung/clk-cpu.c                      |  10 +-
 drivers/clk/samsung/clk-cpu.h                      |   2 +
 drivers/clk/samsung/clk-exynos7.c                  | 183 +++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |  21 ++-
 5 files changed, 219 insertions(+), 3 deletions(-)

-- 
1.9.1
