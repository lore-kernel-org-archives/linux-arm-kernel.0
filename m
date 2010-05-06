From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:23:59 -0700
Subject: [PATCH 08/34] Davinci: allow SOCs based on other ARM CPUs
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-9-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

Preliminary modification prior to adding support for TNETV107X based on
ARM1176.  This change allows for CPUs other than ARM926T to be used for Davinci
derivative SoCs.  Existing devices (DA8x and DMx) operate unchanged.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/Kconfig              |    1 -
 arch/arm/mach-davinci/Kconfig |    2 ++
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 92622eb..1151d1a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -776,7 +776,6 @@ config ARCH_NOMADIK
 
 config ARCH_DAVINCI
 	bool "TI DaVinci"
-	select CPU_ARM926T
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_GPIO
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 0ebe185..0316e20 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -7,6 +7,7 @@ config CP_INTC
 	bool
 
 config ARCH_DAVINCI_DMx
+	select CPU_ARM926T
 	bool
 
 menu "TI DaVinci Implementations"
@@ -41,6 +42,7 @@ config ARCH_DAVINCI_DA850
 	select ARCH_HAS_CPUFREQ
 
 config ARCH_DAVINCI_DA8XX
+	select CPU_ARM926T
 	bool
 
 config ARCH_DAVINCI_DM365
-- 
1.7.0.2
