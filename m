From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sun, 14 Oct 2018 14:34:47 +0000
Subject: [PATCH V2 1/4] arm64: imx: add imx8qxp support
In-Reply-To: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
References: <1539527419-23613-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1539527419-23613-2-git-send-email-aisheng.dong@nxp.com>
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
v1->v2:
 * update CONFIG option name
---
 arch/arm64/Kconfig.platforms | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 393d2b5..c7324b1 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -139,6 +139,28 @@ config ARCH_MVEBU
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
+	select IMX_MBOX
+	select IMX_SCU
+	select IMX_SCU_PD
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
