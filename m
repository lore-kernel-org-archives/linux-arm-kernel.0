From: alan@signal11.us (Alan Ott)
Date: Thu,  1 Mar 2012 14:26:44 -0500
Subject: [PATCH 2/8] ARM: tegra: do not hide dma declarations
In-Reply-To: <1330630010-11241-1-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
Message-ID: <1330630010-11241-3-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The declarations are actually required for the device
definitions, and are still valid even if the dma controller
is disabled:

arch/arm/mach-tegra/devices.c:559:12: error: 'TEGRA_DMA_REQ_SEL_I2S_1' undeclared here (not in a function)
arch/arm/mach-tegra/devices.c:577:12: error: 'TEGRA_DMA_REQ_SEL_I2S2_1' undeclared here (not in a function)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-tegra/include/mach/dma.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/dma.h b/arch/arm/mach-tegra/include/mach/dma.h
index 3c93390..9077092 100644
--- a/arch/arm/mach-tegra/include/mach/dma.h
+++ b/arch/arm/mach-tegra/include/mach/dma.h
@@ -51,8 +51,6 @@
 #define TEGRA_DMA_REQ_SEL_OWR			25
 #define TEGRA_DMA_REQ_SEL_INVALID		31
 
-#if defined(CONFIG_TEGRA_SYSTEM_DMA)
-
 struct tegra_dma_req;
 struct tegra_dma_channel;
 
@@ -151,5 +149,3 @@ void tegra_dma_free_channel(struct tegra_dma_channel *ch);
 int __init tegra_dma_init(void);
 
 #endif
-
-#endif
-- 
1.7.0.4
