From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 17 Feb 2016 11:43:53 +0000
Subject: [PATCH v2 1/8] arm64: Introduce Allwinner SoC config option
In-Reply-To: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
References: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1455709440-8668-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare for the Allwinner A64 SoC support, introduce a config
option to allow compiling Allwinner (aka. sunxi) specific drivers
for the arm64 architecture as well.
This patch just defines the ARCH_SUNXI symbol to allow Allwinner
specific drivers to be selected during kernel configuration.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 8a09522..2f7f69b 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -1,5 +1,10 @@
 menu "Platform selection"
 
+config ARCH_SUNXI
+	bool "Allwinner sunxi 64-bit SoC Family"
+	help
+	  This enables support for Allwinner sunxi based SoCs like the A64.
+
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
 	help
-- 
2.6.4
