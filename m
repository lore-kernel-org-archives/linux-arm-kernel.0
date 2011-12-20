From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 20 Dec 2011 02:42:18 +0200
Subject: [PATCH 01/10] arm: omap4: fix kconfig warning
In-Reply-To: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1324341747-5922-2-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

warning: (ARCH_OMAP4 && ARCH_VEXPRESS_CA9X4) selects ARM_ERRATA_720789 which has unmet direct dependencies (CPU_V7 && SMP)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e1293aa..eb7c3ac 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -46,7 +46,7 @@ config ARCH_OMAP4
 	select LOCAL_TIMERS if SMP
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
-	select ARM_ERRATA_720789
+	select ARM_ERRATA_720789 if SMP
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI
-- 
1.7.8.rc1.14.g248db
