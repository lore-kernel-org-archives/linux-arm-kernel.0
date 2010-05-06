From: saeed@marvell.com (Saeed Bishara)
Date: Thu,  6 May 2010 16:12:05 +0300
Subject: [PATCH] dove: support v7 mode
Message-ID: <1273151526-20190-1-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU of dove can be configured to boot in v7 mode, this patch will enable building the kernel for that mode.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 5bd7c89..e40a35a 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -409,7 +409,7 @@ config CPU_32v6K
 
 # ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
+	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
 	select CPU_32v6K if !ARCH_OMAP2
 	select CPU_32v7
 	select CPU_ABRT_EV7
-- 
1.6.0.4
