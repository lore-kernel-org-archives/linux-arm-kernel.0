From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 29 Jun 2016 11:20:47 +0200
Subject: [RESEND PATCH] ARM: oxnas: Change OX810SE default driver config
Message-ID: <577392EF.7030609@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the SP804 timer changes will not been merged upstream, switch the
default OX810SE config to the OXNAS RPS Timer driver configuration.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-oxnas/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Dear arm-soc maintainers,

Gentle ping/resend about this patch, it would be great to see it in 4.8 !

Daniel just accepted my patchset at :
http://lkml.kernel.org/r/1465985607-21231-1-git-send-email-narmstrong at baylibre.com

And now the default config can be switched to OXNAS_RPS_TIMER without any
device tree changes.

Neil

diff --git a/arch/arm/mach-oxnas/Kconfig b/arch/arm/mach-oxnas/Kconfig
index 4fff3c7..ffcab02 100644
--- a/arch/arm/mach-oxnas/Kconfig
+++ b/arch/arm/mach-oxnas/Kconfig
@@ -11,7 +11,7 @@ if ARCH_OXNAS
  config MACH_OX810SE
 	bool "Support OX810SE Based Products"
-	select ARM_TIMER_SP804
+	select OXNAS_RPS_TIMER
 	select COMMON_CLK_OXNAS
 	select CPU_ARM926T
 	select MFD_SYSCON
-- 
1.9.1
