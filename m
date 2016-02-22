From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 22 Feb 2016 18:20:48 +0000
Subject: [PATCH v3 03/10] arm64: Introduce Allwinner SoC config option
In-Reply-To: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
References: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1456165255-31013-4-git-send-email-andre.przywara@arm.com>
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
index 21074f6..97f5690 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -72,6 +72,11 @@ config ARCH_SEATTLE
 config ARCH_SHMOBILE
 	bool
 
+config ARCH_SUNXI
+	bool "Allwinner sunxi 64-bit SoC Family"
+	help
+	  This enables support for Allwinner sunxi based SoCs like the A64.
+
 config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
 	select ARCH_SHMOBILE
-- 
2.6.4
