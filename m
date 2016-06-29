From: mmayer@broadcom.com (Markus Mayer)
Date: Wed, 29 Jun 2016 12:49:34 -0700
Subject: [PATCH] arm64: Add Broadcom Set Top Box Kconfig entry point
Message-ID: <1467229774-20738-1-git-send-email-mmayer@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>

Add an ARCH_BRCMSTB Kconfig symbol which allows us not to update the
dependencies for all STB-related drivers. Select BRCMSTB_L2_IRQ and
GENERIC_IRQ_CHIP which are required for proper functioning.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---

 arch/arm64/Kconfig.platforms | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7ef1d05..22b5c7f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -29,6 +29,13 @@ config ARCH_BERLIN
 	help
 	  This enables support for Marvell Berlin SoC Family
 
+config ARCH_BRCMSTB
+	bool "Broadcom Set-Top-Box SoCs"
+	select BRCMSTB_L2_IRQ
+	select GENERIC_IRQ_CHIP
+	help
+	  This enables support for Broadcom's ARMv8 Set Top Box SoCs
+
 config ARCH_EXYNOS
 	bool "ARMv8 based Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
-- 
2.7.4
