From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 21 Jan 2013 18:53:59 +0100
Subject: [PATCH 3/6] arm: kconfig: don't select TWD with local timer for
 Armada 370/XP
In-Reply-To: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1358790842-2986-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 and Armada XP SoCs don't use the TWD timers, so don't
select it by default if CONFIG_LOCAL_TIMERS is selected

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..4c4d010 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1624,7 +1624,7 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP
 	default y
-	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
+	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT && !ARMADA_370_XP_TIMER)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
-- 
1.7.9.5
