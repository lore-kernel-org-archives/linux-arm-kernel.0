From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:10 +0100
Subject: [PATCH 13/62] ARM: hisi: select HAVE_ARM_SCU only for SMP
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-14-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCU code does not build unless we are compiling
an SMP kernel. This does the same as every other
platform with an SCU.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-hisi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index 9d0a87b..feee4db 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -4,7 +4,7 @@ config ARCH_HI3xxx
 	select ARM_GIC
 	select ARM_TIMER_SP804
 	select CACHE_L2X0
-	select HAVE_ARM_SCU
+	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
 	select PINCTRL_SINGLE
-- 
1.8.3.2
