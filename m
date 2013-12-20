From: davidb@codeaurora.org (David Brown)
Date: Fri, 20 Dec 2013 11:09:17 -0800
Subject: [PATCH 4/7] ARM: msm: Simplify ARCH_MSM_DT config
In-Reply-To: <1387566560-23948-1-git-send-email-davidb@codeaurora.org>
References: <1387566560-23948-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1387566560-23948-5-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Boyd <sboyd@codeaurora.org>

This doesn't need to be a def_bool y. Instead we can have every
DT supported platform select ARCH_MSM_DT and we achieve the same
thing with less chance of conflicts.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 5e5782d..702553b 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -44,6 +44,7 @@ endchoice
 
 config ARCH_MSM8X60
 	bool "MSM8X60"
+	select ARCH_MSM_DT
 	select ARM_GIC
 	select CPU_V7
 	select GPIO_MSM_V2
@@ -52,6 +53,7 @@ config ARCH_MSM8X60
 
 config ARCH_MSM8960
 	bool "MSM8960"
+	select ARCH_MSM_DT
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_SMP
@@ -60,6 +62,7 @@ config ARCH_MSM8960
 
 config ARCH_MSM8974
 	bool "MSM8974"
+	select ARCH_MSM_DT
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_ARM_ARCH_TIMER
@@ -68,8 +71,7 @@ config ARCH_MSM8974
 	select USE_OF
 
 config ARCH_MSM_DT
-	def_bool y
-	depends on (ARCH_MSM8X60 || ARCH_MSM8960 || ARCH_MSM8974)
+	bool
 	select SPARSE_IRQ
 	select USE_OF
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
