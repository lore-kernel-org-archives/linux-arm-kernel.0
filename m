From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 28 Apr 2018 03:06:14 +0800
Subject: [PATCH 2/5] arm64: imx: add imx8qxp support
In-Reply-To: <1524855977-15719-1-git-send-email-aisheng.dong@nxp.com>
References: <1524855977-15719-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1524855977-15719-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add imx8qxp support.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 arch/arm64/Kconfig.platforms | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2b1535c..8527def 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -132,6 +132,29 @@ config ARCH_MVEBU
 	   - Armada 7K SoC Family
 	   - Armada 8K SoC Family
 
+config ARCH_MXC
+	bool "ARMv8 based NXP i.MX SoC family"
+	select GPIOLIB
+	select PINCTRL
+	select PM
+	select PM_GENERIC_DOMAINS
+	select SOC_BUS
+	help
+	  This enables support for the ARMv8 based SoCs in the
+	  NXP i.MX family.
+
+config SOC_IMX8QXP
+	bool "i.MX8QXP"
+	depends on ARCH_MXC
+	select HAVE_IMX_MU
+	select HAVE_IMX_SCU
+	select HAVE_IMX_SC_PD
+	select HAVE_IMX8_SOC
+	select MXC_CLK_SCU
+	select PINCTRL_IMX8QXP
+	help
+	  This enables support for NXP i.MX8QXP SoC.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.7.4
