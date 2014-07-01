From: k.chander@samsung.com (Chander Kashyap)
Date: Tue,  1 Jul 2014 20:02:36 +0530
Subject: [PATCH 0/2] cpuidle fixes and cleanup
Message-ID: <1404225158-8453-1-git-send-email-k.chander@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes the cpuidle for different states. Also removes arm
diagnostic and power register save/restore code as it is made generic.

Based on:
ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
 http://www.spinics.net/lists/arm-kernel/msg340506.html

ARM: save/restore power control register on Cortex-A9 suspend/resume
 http://www.spinics.net/lists/arm-kernel/msg343320.html

Chander Kashyap (2):
  ARM: Exynos: remove arm diagnostic and power register save/restore
    code
  cpuidle: Exynos: fix cpuidle for all states

 arch/arm/mach-exynos/common.h    |    2 +-
 arch/arm/mach-exynos/pm.c        |   95 +++++---------------------------------
 drivers/cpuidle/cpuidle-exynos.c |    7 ++-
 3 files changed, 17 insertions(+), 87 deletions(-)

-- 
1.7.9.5
