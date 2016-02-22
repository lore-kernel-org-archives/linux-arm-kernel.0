From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 22 Feb 2016 11:23:44 +0000
Subject: [PATCH 1/3] nvmem: Fix dependencies for !HAS_IOMEM archs
In-Reply-To: <1456140161-6851-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456140161-6851-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456140224-6895-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Weinberger <richard@nod.at>

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 5bd18cc..ca52952 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -37,6 +37,7 @@ config NVMEM_LPC18XX_EEPROM
 config NVMEM_MXS_OCOTP
 	tristate "Freescale MXS On-Chip OTP Memory Support"
 	depends on ARCH_MXS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  If you say Y here, you will get readonly access to the
 	  One Time Programmable memory pages that are stored
@@ -59,6 +60,7 @@ config MTK_EFUSE
 config QCOM_QFPROM
 	tristate "QCOM QFPROM Support"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  Say y here to enable QFPROM support. The QFPROM provides access
@@ -70,6 +72,7 @@ config QCOM_QFPROM
 config ROCKCHIP_EFUSE
 	tristate "Rockchip eFuse Support"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This is a simple drive to dump specified values of Rockchip SoC
 	  from eFuse, such as cpu-leakage.
@@ -91,6 +94,7 @@ config NVMEM_SUNXI_SID
 config NVMEM_VF610_OCOTP
 	tristate "VF610 SoC OCOTP support"
 	depends on SOC_VF610 || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This is a driver for the 'OCOTP' peripheral available on Vybrid
 	  devices like VF5xx and VF6xx.
-- 
1.9.1
