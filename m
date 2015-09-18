From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 18 Sep 2015 21:47:37 +0800
Subject: [PATCH 1/3] arm64: berlin: enable ARCH_REQUIRE_GPIOLIB
In-Reply-To: <1442584059-7319-1-git-send-email-jszhang@marvell.com>
References: <1442584059-7319-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442584059-7319-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All berlin SoCs have GPIOs driven by the dwapb GPIO driver. Add GPIOLIB
as a dependency to be able to support them.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 23800a1..c6e2c75 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -7,6 +7,7 @@ config ARCH_BCM_IPROC
 
 config ARCH_BERLIN
 	bool "Marvell Berlin SoC Family"
+	select ARCH_REQUIRE_GPIOLIB
 	select DW_APB_ICTL
 	help
 	  This enables support for Marvell Berlin SoC Family
-- 
2.5.1
