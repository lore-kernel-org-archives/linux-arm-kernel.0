From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue, 16 Aug 2016 22:33:36 +0000
Subject: [PATCH v3 2/4] ARM: davinci_all_defconfig: Enable AEMIF as a module
In-Reply-To: <20160816223338.20776-1-kbeldan@baylibre.com>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
Message-ID: <20160816223338.20776-3-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the use of the memory/ti-aemif.c driver.
ATM most davinci boards use the mach-davinci aemif code which gets in
the way of genericity and proper DT boot.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index d037d3d..2802897 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -192,6 +192,8 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
+CONFIG_MEMORY=y
+CONFIG_TI_AEMIF=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_XFS_FS=m
-- 
2.9.2
