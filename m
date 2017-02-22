From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 22 Feb 2017 03:29:25 +0100
Subject: [PATCH v2 5/8] ARM64: Prepare Marvell IAP140 aka PXA1908
In-Reply-To: <20170222022929.10540-1-afaerber@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
Message-ID: <20170222022929.10540-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make ARCH_MMP available on arm64, too.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Switched from ARCH_PXA to ARCH_MMP - obsoletes clk and mmp Kconfig changes
 * Split off serial Kconfig cleanup
 
 arch/arm64/Kconfig.platforms | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 129cc5a..c3ae8bc 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -111,6 +111,13 @@ config ARCH_MVEBU
 	   - Armada 7K SoC Family
 	   - Armada 8K SoC Family
 
+config ARCH_MMP
+	bool "Marvell MMP SoC Family"
+	select PINCTRL
+	select PINCTRL_SINGLE
+	help
+	  This enables support for the Marvell MMP family.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.10.2
