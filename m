From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Jan 2015 11:22:09 -0800
Subject: [PATCH] ARM: qcom: Drop unnecessary selects from ARCH_QCOM
Message-ID: <1421868129-20798-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't need to force gpiolib on everyone given that it isn't
required to actually boot the device and the multiplatform
Kconfig already selects ARCH_WANT_OPTIONAL_GPIOLIB. CLKSRC_OF is
already selected by CONFIG_ARCH_MULTIPLATFORM too, so we can drop
that here.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Based on qcom/soc at Kumar's tree

 arch/arm/mach-qcom/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index 5e93814f458a..2256cd1e25d1 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -1,10 +1,8 @@
 menuconfig ARCH_QCOM
 	bool "Qualcomm Support" if ARCH_MULTI_V7
-	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_GIC
 	select ARM_AMBA
-	select CLKSRC_OF
 	select PINCTRL
 	select QCOM_SCM if SMP
 	help
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
