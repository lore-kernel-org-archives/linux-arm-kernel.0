From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 18 Apr 2014 11:20:32 +0900
Subject: [PATCH 0/2] Support cpufreq driver for Exynos3250
Message-ID: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset support cpufreq driver for Exynos3250 which uses the Cortex-A7
dual cores and has a target speed of 1.0 GHz and code clean using dev_err/info
instead of pr_err/info function.

This patchset has a dependency on following patchset[1] to support Exynos3250:
[1] https://lkml.org/lkml/2014/4/17/669

Chanwoo Choi (2):
  cpufreq: exynos: Use dev_err/info function instead of pr_err/info
  cpufreq: exynos: Add new Exynos3250 cpufreq driver

 drivers/cpufreq/Kconfig.arm          |  11 +++
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/exynos-cpufreq.c     |  25 +++---
 drivers/cpufreq/exynos-cpufreq.h     |  18 ++++
 drivers/cpufreq/exynos3250-cpufreq.c | 158 +++++++++++++++++++++++++++++++++++
 5 files changed, 203 insertions(+), 10 deletions(-)
 create mode 100644 drivers/cpufreq/exynos3250-cpufreq.c

-- 
1.8.0
