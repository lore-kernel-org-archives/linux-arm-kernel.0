From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:48 +0200
Subject: [PATCH 16/26] ARM: pxa: CPU_PJ4 requires IWMMXT
In-Reply-To: <1317499438-14058-1-git-send-email-arnd@arndb.de>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
Message-ID: <1317499438-14058-17-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PJ4 based pxa95x cpus all have iwmmxt and there is no way to
build that code conditionally, so better not ask the user
in that configuration, in order to prevent broken builds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5ebc5d9..570c9fd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1071,7 +1071,7 @@ config ARM_TIMER_SP804
 source arch/arm/mm/Kconfig
 
 config IWMMXT
-	bool "Enable iWMMXt support"
+	bool "Enable iWMMXt support" if !CPU_PJ4
 	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4
 	default y if PXA27x || PXA3xx || PXA95x || ARCH_MMP
 	help
-- 
1.7.5.4
