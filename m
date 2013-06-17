From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 17 Jun 2013 10:45:15 +0100
Subject: [PATCH 1/2] arm: vexpress: select HAVE_ARM_ARCH_TIMER
In-Reply-To: <1371462316-9201-1-git-send-email-mark.rutland@arm.com>
References: <1371462316-9201-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1371462316-9201-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a ARCH_MULTI_V7 kernel, support for the architected timers
won't be enabled out-of-the-box even when ARCH_VEXPRESS is selected,
which is unexpected and disappointing when using a coretile with
architected timers.

Fix this up by having ARCH_VEXPRESS select HAVE_ARM_ARCH_TIMER.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 5907e10..e0f4974 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -9,6 +9,7 @@ config ARCH_VEXPRESS
 	select COMMON_CLK_VERSATILE
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_CLK
-- 
1.8.1.1
