From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Jun 2017 15:28:37 +0100
Subject: [PATCH v2 5/5] ARM: mach-virt: Select PMUv3 driver by default
In-Reply-To: <20170613142837.29738-1-marc.zyngier@arm.com>
References: <20170613142837.29738-1-marc.zyngier@arm.com>
Message-ID: <20170613142837.29738-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 32bit guests are not unlikely to run on an ARMv8 host,
let's select the PMUv3 driver, which allows the PMU to be used
on such systems.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c1a35f15838..711a426cbb0d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -702,6 +702,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
+	select ARM_PMUV3 if PERF_EVENTS
 	select HAVE_ARM_ARCH_TIMER
 
 #
-- 
2.11.0
