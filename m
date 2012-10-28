From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 28 Oct 2012 19:31:06 +0100
Subject: [PATCH v3 1/6] ARM: AT91: Fix build failure on board-dt
In-Reply-To: <1351449071-5763-1-git-send-email-manabian@gmail.com>
References: <1351449071-5763-1-git-send-email-manabian@gmail.com>
Message-ID: <1351449071-5763-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need CONFIG_SOC_AT91SAM9 to get the at91sam926x_timer
symbol used in board-dt.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 9285768..cc7a15c 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -492,6 +492,7 @@ comment "Generic Board Type"
 
 config MACH_AT91SAM_DT
 	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
+	depends on SOC_AT91SAM9
 	select USE_OF
 	help
 	  Select this if you want to experiment device-tree with
-- 
1.8.0
