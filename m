From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 22 Oct 2009 22:01:25 +0200
Subject: [PATCH 1/2] arm: remove redund depend on of config LOCAL_TIMERS
Message-ID: <1256241686-28647-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the machines and arch depned list is already predent at SMP config

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..beb1340 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1026,8 +1026,7 @@ config HOTPLUG_CPU
 
 config LOCAL_TIMERS
 	bool "Use local timer interrupts"
-	depends on SMP && (REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || \
-		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4)
+	depends on SMP
 	default y
 	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_OMAP4)
 	help
-- 
1.6.3.1
