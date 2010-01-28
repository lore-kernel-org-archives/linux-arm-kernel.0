From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 28 Jan 2010 14:59:26 -0800
Subject: [RFC PATCH 01/12] arm: msm: allow ARCH_MSM to have v7 cpus
Message-ID: <1264719577-5436-2-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARCH_MSM supports armv7 cpus, so we're pushed the CPU_V6/CPU_V7 selection
down into the arch/arm/mach-msm/Kconfig.

Also update the description to be a bit more accurate.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig          |   10 +++++-----
 arch/arm/mach-msm/Kconfig |    2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..71fb8b1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -575,14 +575,14 @@ config ARCH_PXA
 
 config ARCH_MSM
 	bool "Qualcomm MSM"
-	select CPU_V6
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
-	  Support for Qualcomm MSM7K based systems.  This runs on the ARM11
-	  apps processor of the MSM7K and depends on a shared memory
-	  interface to the ARM9 modem processor which runs the baseband stack
-	  and controls some vital subsystems (clock and power control, etc).
+	  Support for Qualcomm MSM/QSD based systems.  This runs on the
+	  apps processor of the MSM/QSD and depends on a shared memory
+	  interface to the modem processor which runs the baseband
+	  stack and controls some vital subsystems
+	  (clock and power control, etc).
 
 config ARCH_RPC
 	bool "RiscPC"
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index f780086..b9fd5c5 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -29,12 +29,14 @@ endchoice
 
 config MACH_HALIBUT
 	depends on ARCH_MSM
+	select CPU_V6
 	default y
 	bool "Halibut Board (QCT SURF7201A)"
 	help
 	  Support for the Qualcomm SURF7201A eval board.
 
 config MACH_TROUT
+	select CPU_V6
 	default y
 	bool "HTC Dream (aka trout)"
 	help
-- 
1.6.3.3
