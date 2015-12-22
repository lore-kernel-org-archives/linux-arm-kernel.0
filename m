From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 22 Dec 2015 12:27:47 +0000
Subject: [RFC PATCH 5/5] arm64: Introduce Allwinner SoC config option
In-Reply-To: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1450787267-26836-6-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare for supporting the Allwinner A64 SoC, introduce a config
option to allow compiling Allwinner (aka. sunxi) specific drivers
for ARM64.
This patch just defines the ARCH_SUNXI symbol to allow Allwinner
specific drivers to be selected during kernel configuration.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4043c35..235e376 100644
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
2.5.1
