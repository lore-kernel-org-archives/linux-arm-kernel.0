From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 22 Jan 2013 18:42:44 +0100
Subject: [PATCH] arm: kconfig: always select TWD with local timer for
 multiplatform
In-Reply-To: <50FEBF96.6020001@free-electrons.com>
References: <50FEBF96.6020001@free-electrons.com>
Message-ID: <1358876564-25239-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we enable multiplatform and local timers we should not disable
the build of the TWD driver even if there is support for MSM and/or
EXYNOS (those SoCs don't use TWD for their local timers). Indeed most
of the other SoCs will need it.

If multiplatform is not enable we keep the possibility to not add
support for TWD as we only built a kernel for MSM or for EXYNOS.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..482ee23 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1625,6 +1625,7 @@ config LOCAL_TIMERS
 	depends on SMP
 	default y
 	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
+	select HAVE_ARM_TWD if ARCH_MULTIPLATFORM
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
-- 
1.7.9.5
