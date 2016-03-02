From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed,  2 Mar 2016 03:34:56 +0100
Subject: [PATCH v2 1/6] ARM64: Enable Amlogic Meson GXBaby platform
In-Reply-To: <1456886101-22967-1-git-send-email-afaerber@suse.de>
References: <1456886101-22967-1-git-send-email-afaerber@suse.de>
Message-ID: <1456886101-22967-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the ARCH_MESON Kconfig symbol to allow enabling existing serial
and i2c drivers.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2:
 * Dropped ARM_GIC selection (Sudeep)
 
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a0a69589e46c..a14e024b63a9 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -56,6 +56,11 @@ config ARCH_MEDIATEK
 	help
 	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
 
+config ARCH_MESON
+	bool "Amlogic Platforms"
+	help
+	  This enables support for the Amlogic S905 SoCs.
+
 config ARCH_MVEBU
 	bool "Marvell EBU SoC Family"
 	select ARMADA_AP806_CORE_CLK
-- 
2.6.2
