From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Apr 2016 09:49:08 +0200
Subject: [PATCH v4 4/5] dmaengine: mv_xor: Allow selecting mv_xor for mvebu
 only compatible SoC
In-Reply-To: <1461916149-30900-1-git-send-email-gregory.clement@free-electrons.com>
References: <1461916149-30900-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1461916149-30900-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 3700 SoC uses the mv_xor driver but don't select anymore the
PLAT_ORION symbol. This commit extends the dependency of the mv_xor
driver to the more modern SoCs only compatible with ARCH_MVEBU, which
allows using it with the Armada 3700 SoC.

In the same time it also add the COMPILE_TEST dependency allowing a wider
test coverage.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/dma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d96d87c56f2e..67b37ce94143 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -332,7 +332,7 @@ config MPC512X_DMA
 
 config MV_XOR
 	bool "Marvell XOR engine support"
-	depends on PLAT_ORION
+	depends on PLAT_ORION || ARCH_MVEBU || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_ENGINE_RAID
 	select ASYNC_TX_ENABLE_CHANNEL_SWITCH
-- 
2.5.0
