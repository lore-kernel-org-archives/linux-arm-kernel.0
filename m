From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 24 Nov 2016 01:17:13 +0000
Subject: [RFC PATCH 3/5] arm64: defconfig: sunxi: include options for
 Allwinner H5 SoC
In-Reply-To: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
References: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1479950235-26821-4-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner H5 SoC is closely related to the H3 SoC, so select the
basic pinctrl driver and the DMA driver to let a defconfig kernel boot
on those boards.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/Kconfig.platforms | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cfbdf02..8300677 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -5,8 +5,12 @@ config ARCH_SUNXI
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
 	select PINCTRL_SUN50I_A64
+	select PINCTRL_SUN8I_H3
+	select PINCTRL_SUN8I_H3_R
+	select DMA_SUN6I
 	help
-	  This enables support for Allwinner sunxi based SoCs like the A64.
+	  This enables support for Allwinner sunxi based SoCs like the A64
+	  and the H5.
 
 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
-- 
2.8.2
