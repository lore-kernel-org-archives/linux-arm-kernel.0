From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 20 Dec 2011 02:42:19 +0200
Subject: [PATCH 02/10] arm: vexpress: fix kconfig warning
In-Reply-To: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1324341747-5922-3-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

warning: (ARCH_OMAP4 && ARCH_VEXPRESS_CA9X4) selects ARM_ERRATA_720789 which has unmet direct dependencies (CPU_V7 && SMP)
warning: (ARCH_VEXPRESS_CA9X4) selects ARM_ERRATA_751472 which has unmet direct dependencies (CPU_V7 && SMP)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-vexpress/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 9311484..3fbcb8c 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,8 +5,8 @@ config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 	select CPU_V7
 	select ARM_GIC
-	select ARM_ERRATA_720789
-	select ARM_ERRATA_751472
+	select ARM_ERRATA_720789 if SMP
+	select ARM_ERRATA_751472 if SMP
 	select ARM_ERRATA_753970
 
 endmenu
-- 
1.7.8.rc1.14.g248db
