From: pawel.moll@arm.com (Pawel Moll)
Date: Tue,  9 Apr 2013 14:17:50 +0100
Subject: [PATCH] ARM: vexpress: Remove A9 PMU compatible values for non-A9
 platforms
Message-ID: <1365513470-2680-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM perf core code used to rely on the pmu node being
compatible with "arm,cortex-a9-pmu", even when the PMUs
of the different Cortex-A processors are not really
compatible... This is no longer required and actually
became harmful, so remove all the offending values
from Versatile Express DTS files.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
Hello Arnd, Olof,

Could you please add this patch to your fixes branch for 3.10 or
to pull from the tag below?

Thanks,

Pawel

The following changes since commit f011a08c804d50eeff4abf2d308cdce492f015aa:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/sfr/next-fixes (2013-04-08 16:10:43 -0700)

are available in the git repository at:


  git://git.linaro.org/people/pawelmoll/linux.git tags/vexpress/fixes-for-3.10

for you to fetch changes up to a8baa6ab9cfe01f16f08fdae22796a21ee2ab21d:

  ARM: vexpress: Remove A9 PMU compatible values for non-A9 platforms (2013-04-09 14:03:51 +0100)

----------------------------------------------------------------
Versatile Express fixes for 3.10:
* Fix PMU compatible values in non-A9 DTSes

----------------------------------------------------------------

 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |    2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  |    2 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 7318717..9420053 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -117,7 +117,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a15-pmu", "arm,cortex-a9-pmu";
+		compatible = "arm,cortex-a15-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
 	};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index dfe371e..d2803be 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -134,7 +134,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a15-pmu", "arm,cortex-a9-pmu";
+		compatible = "arm,cortex-a15-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
 	};
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index 6328cbc..c544a55 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -111,7 +111,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a5-pmu", "arm,cortex-a9-pmu";
+		compatible = "arm,cortex-a5-pmu";
 		interrupts = <0 68 4>,
 			     <0 69 4>;
 	};
-- 
1.7.10.4
