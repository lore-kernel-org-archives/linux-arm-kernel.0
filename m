From: mbrugger@suse.com (Matthias Brugger)
Date: Wed, 13 Apr 2016 12:30:56 +0200
Subject: [PATCH 6/6] Revert "staging: fsl-mc: Do not allow building as a
 module"
In-Reply-To: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
References: <1460543456-11345-1-git-send-email-mbrugger@suse.com>
Message-ID: <1460543456-11345-7-git-send-email-mbrugger@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Matthias Brugger <matthias.bgg@gmail.com>

This reverts commit <dfb11fe2281c> ("staging: fsl-mc: Do not allow building as a module")

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/staging/fsl-mc/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 1f95933..c498ac6 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -7,7 +7,7 @@
 #
 
 config FSL_MC_BUS
-	bool "Freescale Management Complex (MC) bus driver"
+	tristate "Freescale Management Complex (MC) bus driver"
 	depends on OF && ARM64
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
-- 
2.6.6
