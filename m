From: amit.kachhap@linaro.org (Amit Daniel Kachhap)
Date: Fri, 11 Nov 2011 11:59:32 +0530
Subject: [PATCH V2 0/5] ARM: exynos4: Add l2 retention mode cpuidle state
Message-ID: <1320992977-11589-1-git-send-email-amit.kachhap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since V1:
*rebased the whole patch against 3.2-rc1 tree
*removed GIC save/restore in AFTR cpuidle state as it is external 
to cpu powerdomain
*Added L2 setup code through device tree
*Removed only l2 save/restore registers in sleep

This Patch series adds support for AFTR mode cpuidle state based on 
patch (http://www.spinics.net/lists/arm-kernel/msg132243.html) earlier
submitted by Jaecheol Lee <jc.lee@samsung.com>.

This patch uses CPU PM notifiers , common l2 save/restore and 
new cpu_suspend/resume interfaces and is based on the tip of 
for-next branch of samsung tree.
(git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next). 

Amit Daniel Kachhap (5):
  ARM: exynos4: Add support for AFTR mode cpuidle state
  ARM: exynos4: remove useless churn in sleep.S
  ARM: exynos4: add L2 early resume code
  ARM: exynos4: remove useless code to save/restore L2
  ARM: exynos4: Enable l2 configuration through device tree

 arch/arm/mach-exynos/cpu.c              |   60 +++++++++----
 arch/arm/mach-exynos/cpuidle.c          |  148 ++++++++++++++++++++++++++++++-
 arch/arm/mach-exynos/include/mach/pmu.h |    2 +
 arch/arm/mach-exynos/pm.c               |   15 ---
 arch/arm/plat-s5p/sleep.S               |   32 +++++++-
 5 files changed, 221 insertions(+), 36 deletions(-)
