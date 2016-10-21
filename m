From: michael.scott@linaro.org (Michael Scott)
Date: Fri, 21 Oct 2016 10:56:08 -0700
Subject: [PATCH] arm64: qcom: enable GPIOLIB in Kconfig
Message-ID: <20161021175608.19073-1-michael.scott@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While debugging a kernel image size issue, I discovered that if all
non ARCH_QCOM configs in the ARM64 defconfig are disabled, the QCOM
pinctrl drivers will not be built.

The QCOM pinctrl drivers have a dependency on GPIOLIB which was being
selected when other ARCH configs were enabled, but ARCH_QCOM doesn't
select GPIOLIB directly.  Let's select GPIOLIB here to ensure the pinctrl
drivers are built for QCOM platforms.

Signed-off-by: Michael Scott <michael.scott@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index cfbdf02..e9fc226 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -113,6 +113,7 @@ config ARCH_MVEBU
 
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
+	select GPIOLIB
 	select PINCTRL
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
-- 
2.9.3
