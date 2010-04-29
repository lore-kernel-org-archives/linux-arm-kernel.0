From: PeterHuewe@gmx.de (Peter Huewe)
Date: Thu, 29 Apr 2010 02:31:03 +0200
Subject: [PATCH] arch/arm: Fix missing define for ARM_PMU_DEVICE_CPU
Message-ID: <201004290231.03440.PeterHuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Huewe <peterhuewe@gmx.de>

This patch adds a define for ARM_PMU_DEVICE_CPU which seemed to be
missing/undefined and caused some build failures [1-4].

I defined ARM_PMU_DEVICE_CPU = -1 as stated in
Documentation/driver_model/platform.txt to indicate there is only one.
I'm _not_ sure if this is correct, but due to the static nature of the
define I assume it is.


References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2535843/
[2] http://kisskb.ellerman.id.au/kisskb/buildresult/2535842/
[3] http://kisskb.ellerman.id.au/kisskb/buildresult/2535820/
[4] http://kisskb.ellerman.id.au/kisskb/buildresult/2535819/

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: linux-next-20100429

 arch/arm/include/asm/pmu.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 2829b9f..9b186e2 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -13,6 +13,7 @@
 #define __ARM_PMU_H__
 
 #ifdef CONFIG_CPU_HAS_PMU
+#define ARM_PMU_DEVICE_CPU -1
 
 struct pmu_irqs {
 	const int   *irqs;
-- 
1.6.4.4
