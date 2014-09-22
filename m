From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 22 Sep 2014 14:42:39 -0700
Subject: [PATCH] ARM: qcom: Select ARCH_SUPPORTS_BIG_ENDIAN
Message-ID: <1411422159-25534-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can run qcom platforms in big-endian mode. Select the option.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

It's sad that we have to select this Kconfig. I'm tempted to remove
the config given that we don't have anything like this for other things
like LPAE support. Anyway, this is required to actually test big-endian
on qcom platforms.

 arch/arm/mach-qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index ee5697ba05bc..29aa8e1970b0 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_QCOM
 	bool "Qualcomm Support" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_GIC
 	select ARM_AMBA
 	select CLKSRC_OF
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
