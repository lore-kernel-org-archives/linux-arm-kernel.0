From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Mon,  5 May 2014 07:27:27 +0200
Subject: [PATCH v3 5/7] ARM: berlin: add the pinctrl dependency for the
 Marvell Berlin SoCs
In-Reply-To: <1399267649-20218-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1399267649-20218-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1399267649-20218-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-berlin/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index d3c5f14dc142..9c2b569e54ba 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -4,6 +4,7 @@ config ARCH_BERLIN
 	select GENERIC_IRQ_CHIP
 	select DW_APB_ICTL
 	select DW_APB_TIMER_OF
+	select PINCTRL
 
 if ARCH_BERLIN
 
@@ -14,11 +15,13 @@ config MACH_BERLIN_BG2
 	select CACHE_L2X0
 	select CPU_PJ4B
 	select HAVE_ARM_TWD if SMP
+	select PINCTRL_BERLIN_BG2
 
 config MACH_BERLIN_BG2CD
 	bool "Marvell Armada 1500-mini (BG2CD)"
 	select CACHE_L2X0
 	select HAVE_ARM_TWD if SMP
+	select PINCTRL_BERLIN_BG2CD
 
 config MACH_BERLIN_BG2Q
 	bool "Marvell Armada 1500 Pro (BG2-Q)"
@@ -26,6 +29,7 @@ config MACH_BERLIN_BG2Q
 	select CPU_V7
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
+	select PINCTRL_BERLIN_BG2Q
 
 endmenu
 
-- 
1.8.3.2
