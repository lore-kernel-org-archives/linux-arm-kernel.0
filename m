From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Feb 2014 12:04:25 +0100
Subject: [PATCH v3 03/13] ARM: mvebu: make CPU_PJ4B selection a per-SoC choice
In-Reply-To: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392289475-8902-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, the CPU_PJ4B Kconfig option was selected by
MACH_ARMADA_MVEBU, i.e for all Armada MVEBU SOCs. In preparation to
the introduction of Cortex-A9 based Armada MVEBU SOCs, this selection
is moved down to the Armada 370 and Armada XP specific options.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 35ef594..c934f92 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -26,11 +26,11 @@ config MACH_ARMADA_MVEBU
 	select ARMADA_370_XP_TIMER
 	select HAVE_SMP
 	select CACHE_L2X0
-	select CPU_PJ4B
 
 config MACH_ARMADA_370
 	bool "Marvell Armada 370 boards"
 	select ARMADA_370_CLK
+	select CPU_PJ4B
 	select MACH_ARMADA_MVEBU
 	select PINCTRL_ARMADA_370
 	help
@@ -40,6 +40,7 @@ config MACH_ARMADA_370
 config MACH_ARMADA_XP
 	bool "Marvell Armada XP boards"
 	select ARMADA_XP_CLK
+	select CPU_PJ4B
 	select MACH_ARMADA_MVEBU
 	select PINCTRL_ARMADA_XP
 	help
-- 
1.8.3.2
