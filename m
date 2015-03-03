From: leo.yan@linaro.org (Leo Yan)
Date: Tue,  3 Mar 2015 21:03:35 +0800
Subject: [PATCH 0/2] cpufreq-dt: support for cluster level clock
Message-ID: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for cluster level clock domain for cpufreq-dt driver.

With this support, then cpufreq driver which using cpufreq-dt as
backend can easily apply on multi-clusters system with cluster
level clock domain.

The first patch has been back ported to 3.18 and tested on hikey
board, the second patch is only compiled successfully.

Leo Yan (2):
  cpufreq-dt: support cluster level clock
  ARM: mvebu: update cpufreq-dt's platform data

 arch/arm/mach-mvebu/pmsu.c   |  2 +-
 drivers/cpufreq/Kconfig      |  5 +++--
 drivers/cpufreq/cpufreq-dt.c | 14 +++++++++++++-
 include/linux/cpufreq-dt.h   | 16 ++++++++++++----
 4 files changed, 29 insertions(+), 8 deletions(-)

-- 
1.9.1
