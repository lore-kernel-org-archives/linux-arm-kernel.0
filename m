From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 24 Apr 2013 12:12:35 +0800
Subject: [PATCH] ARM: Kconfig: let ARM9TDMI and ARM7TDMI invisible.
In-Reply-To: <5174D4FA.70404@asianux.com>
References: <514FB202.3040807@asianux.com> <515BFA8D.2000204@asianux.com>
 <20130403101018.GE11040@mudshark.cambridge.arm.com>
 <515C047A.9010906@asianux.com> <516E6A8E.3000001@asianux.com>
 <20130417100243.GV14496@n2100.arm.linux.org.uk> <5174D4FA.70404@asianux.com>
Message-ID: <51775BB3.6000607@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


If CONFIG_MMU is disabled, it will let ARM9TDMI and ARM7TDMI visible,
but in fact, only AT91X40 need ARM7TDMI, so not need let them visible.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-at91/Kconfig.non_dt |    1 +
 arch/arm/mm/Kconfig               |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig.non_dt
b/arch/arm/mach-at91/Kconfig.non_dt
index 6c24985..dc972e1 100644
--- a/arch/arm/mach-at91/Kconfig.non_dt
+++ b/arch/arm/mach-at91/Kconfig.non_dt
@@ -47,6 +47,7 @@ config ARCH_AT91X40
 	select ARCH_USES_GETTIMEOFFSET
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
+	select CPU_ARM7TDMI

 endchoice

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9e8101e..3397d05 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -6,7 +6,7 @@ comment "Processor Type"

 # ARM7TDMI
 config CPU_ARM7TDMI
-	bool "Support ARM7TDMI processor"
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
@@ -56,7 +56,7 @@ config CPU_ARM740T

 # ARM9TDMI
 config CPU_ARM9TDMI
-	bool "Support ARM9TDMI processor"
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
-- 
1.7.7.6
