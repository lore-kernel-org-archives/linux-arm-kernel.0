From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 13 Oct 2015 23:31:38 +0200
Subject: [PATCH 2/5] ARM: berlin: remove the pinctrl selection from the
 mach-berlin Kconfig
In-Reply-To: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1444771901-24460-3-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the pinctrl driver selection from the mach-berlin
Kconfig file. This is now done in the Berlin pinctrl driver Kconfig.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/mach-berlin/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index 742d53a5f7f9..344434ca366c 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -18,19 +18,16 @@ config MACH_BERLIN_BG2
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
-	select PINCTRL_BERLIN_BG2
 
 config MACH_BERLIN_BG2CD
 	bool "Marvell Armada 1500-mini (BG2CD)"
 	select CACHE_L2X0
 	select HAVE_ARM_TWD if SMP
-	select PINCTRL_BERLIN_BG2CD
 
 config MACH_BERLIN_BG2Q
 	bool "Marvell Armada 1500 Pro (BG2-Q)"
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select PINCTRL_BERLIN_BG2Q
 
 endif
-- 
2.6.1
