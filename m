From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  2 Dec 2011 21:23:35 +0100
Subject: [PATCH] ARM: determine PHYS_OFFSET automatically for no-mmu configs
In-Reply-To: <alpine.LFD.2.02.1112021426420.2357@xanadu.home>
References: <alpine.LFD.2.02.1112021426420.2357@xanadu.home>
Message-ID: <1322857415-26753-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Pitre <nicolas.pitre@linaro.org>

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..763de24 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -220,8 +220,9 @@ config NEED_MACH_MEMORY_H
 	  be avoided when possible.
 
 config PHYS_OFFSET
-	hex "Physical address of main memory"
+	hex "Physical address of main memory" if MMU
 	depends on !ARM_PATCH_PHYS_VIRT && !NEED_MACH_MEMORY_H
+	default DRAM_BASE if !MMU
 	help
 	  Please provide the physical address corresponding to the
 	  location of main memory in your system.
-- 
1.7.7.3
