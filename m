From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  1 Feb 2016 17:39:23 +0000
Subject: [PATCH 04/11] arm64: Introduce Allwinner SoC config option
In-Reply-To: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1454348370-3816-5-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare for the Allwinner A64 SoC support, introduce a config
option to allow compiling Allwinner (aka. sunxi) specific drivers
for the arm64 architecture as well.
This patch just defines the ARCH_SUNXI symbol to allow Allwinner
specific drivers to be selected during kernel configuration.
Since the MMC driver is quite essential for Linux to be useful, select
it by default.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f6..fc7cf4b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -1,5 +1,11 @@
 menu "Platform selection"
 
+config ARCH_SUNXI
+	bool "Allwinner sunxi 64-bit SoC Family"
+	select SUNXI_MMC
+	help
+	  This enables support for Allwinner sunxi based SoCs like the A64.
+
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
 	help
-- 
2.6.4
