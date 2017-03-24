From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Mar 2017 12:15:29 +0000
Subject: [PATCH 4/4] ARM: mach-virt: Select PMUv3 driver by default
In-Reply-To: <20170324121529.22603-1-marc.zyngier@arm.com>
References: <20170324121529.22603-1-marc.zyngier@arm.com>
Message-ID: <20170324121529.22603-5-marc.zyngier@arm.com>
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
index 0d4e71b42c77..60bb0e0a807d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -711,6 +711,7 @@ config ARCH_VIRT
 	select ARM_GIC_V3
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
+	select ARM_PMUV3 if PERF_EVENTS
 	select HAVE_ARM_ARCH_TIMER
 
 #
-- 
2.11.0
