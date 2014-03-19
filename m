From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:19 +0100
Subject: [PATCH 22/62] ARM: msm: export legacy DMA interfaces
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-23-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm_sdcc MMC driver and the msm_serial_hs uart driver both
use the pre-dmaengine interfaces provided by the MSM platform.

Since these drivers can be loadable modules, we should export
the functions used in the drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
---
 arch/arm/mach-msm/dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-msm/dma.c b/arch/arm/mach-msm/dma.c
index ba62f02..fb976246 100644
--- a/arch/arm/mach-msm/dma.c
+++ b/arch/arm/mach-msm/dma.c
@@ -78,6 +78,7 @@ void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful)
 {
 	writel((graceful << 31), DMOV_FLUSH0(id));
 }
+EXPORT_SYMBOL_GPL(msm_dmov_stop_cmd);
 
 void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd)
 {
@@ -116,6 +117,7 @@ void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd)
 	}
 	spin_unlock_irqrestore(&msm_dmov_lock, irq_flags);
 }
+EXPORT_SYMBOL_GPL(msm_dmov_enqueue_cmd);
 
 struct msm_dmov_exec_cmdptr_cmd {
 	struct msm_dmov_cmd dmov_cmd;
-- 
1.8.3.2
