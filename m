From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jun 2010 14:47:26 +0300
Subject: [PATCH 2/6] omap: Use 32KiHZ timer by default
In-Reply-To: <20100629113229.16008.2931.stgit@baageli.muru.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
Message-ID: <20100629114725.16008.68154.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 32KiHZ timer by default as this is available on all omaps
except 15xx based systems.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 78b49a6..3e2e7a8 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -120,7 +120,7 @@ config OMAP_IOMMU_DEBUG
 
 choice
 	prompt "System timer"
-	default OMAP_MPU_TIMER
+	default OMAP_32K_TIMER if !ARCH_OMAP15XX
 
 config OMAP_MPU_TIMER
 	bool "Use mpu timer"
