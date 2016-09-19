From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 19 Sep 2016 11:22:41 +0200
Subject: [PATCH] ARM: mvebu: let Armada XP also select corediv clk
Message-ID: <1474276961-4645-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An Armada XP there is also a marvell,armada-370-corediv-clock
compatible device that is needed to make the nand device work.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mvebu/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index f9b6bd306cfe..2979a9c454f6 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -97,6 +97,7 @@ config MACH_ARMADA_XP
 	select CPU_PJ4B
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_XP
+	select MVEBU_CLK_COREDIV
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada XP SoC with device tree.
-- 
2.8.1
