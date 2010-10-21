From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 21 Oct 2010 11:37:35 -0700
Subject: [RFC PATCH] arm: msm: moved Kconfig machine entry into mach-msm
Message-ID: <1287686255-18674-1-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Has anyone suggested this? It seems like it might reduce conflicts
in the Kconfig file.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/Kconfig               |   12 +-----------
 arch/arm/mach-msm/Kconfig.base |   13 +++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/mach-msm/Kconfig.base

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 88c97bc..e256564 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -590,17 +590,7 @@ config ARCH_PXA
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-config ARCH_MSM
-	bool "Qualcomm MSM"
-	select HAVE_CLK
-	select GENERIC_CLOCKEVENTS
-	select ARCH_REQUIRE_GPIOLIB
-	help
-	  Support for Qualcomm MSM/QSD based systems.  This runs on the
-	  apps processor of the MSM/QSD and depends on a shared memory
-	  interface to the modem processor which runs the baseband
-	  stack and controls some vital subsystems
-	  (clock and power control, etc).
+source "arch/arm/mach-msm/Kconfig.base"
 
 config ARCH_SHMOBILE
 	bool "Renesas SH-Mobile"
diff --git a/arch/arm/mach-msm/Kconfig.base b/arch/arm/mach-msm/Kconfig.base
new file mode 100644
index 0000000..184ac66
--- /dev/null
+++ b/arch/arm/mach-msm/Kconfig.base
@@ -0,0 +1,13 @@
+
+config ARCH_MSM
+	bool "Qualcomm MSM"
+	select HAVE_CLK
+	select GENERIC_CLOCKEVENTS
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Support for Qualcomm MSM/QSD based systems.  This runs on the
+	  apps processor of the MSM/QSD and depends on a shared memory
+	  interface to the modem processor which runs the baseband
+	  stack and controls some vital subsystems
+	  (clock and power control, etc).
+
-- 
1.7.0.4
