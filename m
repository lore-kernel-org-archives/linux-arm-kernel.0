From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 14:16:52 +0100
Subject: [PATCH 0/3] cpufreq: build fixes
Message-ID: <1422451015-390439-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These came out of running randconfig build tests on ARM. The three
patches are completely independent, so please apply what looks good.

The two s3c patches are for old bugs and should go through the
cpufreq tree.

The exynos bug only exists in the thermal-soc tree at the moment
and should get picked up by Eduardo with an Ack from the cpufreq
maintainers, or alternatively the bug should get fixed differently
if someone can come up with a better solution.

Arnd Bergmann (3):
  cpufreq: s3c: remove incorrect __init annotations
  cpufreq: s3c: remove last use of resume_clocks callback
  cpufreq: exynos: allow modular build

 drivers/cpufreq/Kconfig.arm          | 14 +++++++++-----
 drivers/cpufreq/exynos-cpufreq.h     |  6 +++---
 drivers/cpufreq/exynos4210-cpufreq.c |  1 +
 drivers/cpufreq/exynos4x12-cpufreq.c |  1 +
 drivers/cpufreq/exynos5250-cpufreq.c |  1 +
 drivers/cpufreq/s3c2416-cpufreq.c    |  4 ++--
 drivers/cpufreq/s3c24xx-cpufreq.c    | 10 +---------
 7 files changed, 18 insertions(+), 19 deletions(-)

-- 
2.1.0.rc2
